using EventGridEventTrigger.Library;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Azure.EventGrid;
using Microsoft.Azure.EventGrid.Models;
using Newtonsoft.Json;
using Newtonsoft.Json.Linq;
using System;
using System.Linq;
using System.Net.Http;

namespace EventGrid.Webhook.Controllers
{
    [Produces("application/json")]
    public class WeatherForecastController : ControllerBase
    {
        [HttpPost]
        [Route("api/EventGridEventHandler")]
        public IActionResult Post([FromBody]object request)
        {
            //Deserializing the request 
            var eventGridEvent = JsonConvert.DeserializeObject<EventGridEvent[]>(request.ToString())
                .FirstOrDefault();
            var data = eventGridEvent.Data as JObject;

            // Validate whether EventType is of "Microsoft.EventGrid.SubscriptionValidationEvent"
            if (string.Equals(eventGridEvent.EventType, EventTypes.EventGridSubscriptionValidationEvent, StringComparison.OrdinalIgnoreCase))
            {
                var eventData = data.ToObject<SubscriptionValidationEventData>();
                var responseData = new SubscriptionValidationResponse
                {
                    ValidationResponse = eventData.ValidationCode
                };

                if (responseData.ValidationResponse != null)
                {
                    return Ok(responseData);
                }
            }
            else
            {
                // Handle your custom event
                var eventData = data.ToObject<CustomData>();
                var customEvent = CustomEvent<CustomData>.CreateCustomEvent(eventData);
                return Ok(customEvent);
            }

            return Ok(new HttpResponseMessage(System.Net.HttpStatusCode.OK));
        }
    }
}
