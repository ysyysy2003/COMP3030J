<template>
  <div class="footer">
    <!-- Start Footer Top -->
    <div class="footer-top">
      <div class="container">
        <div class="row">
          <div class="col-lg-3 col-md-6 col-12"/>
          <div class="col-lg-3 col-md-6 col-12"/>
          <div class="col-lg-3 col-md-6 col-12">
            <!-- Single Widget -->
            <div class="single-footer f-link">
              <h3>Quick Links</h3>
              <ul>
                <li><router-link to="about">About Us</router-link></li>
                <li><router-link to="login">Login</router-link></li>
                <li><router-link to="">Help & Support</router-link></li>
              </ul>
            </div>
            <!-- End Single Widget -->
          </div>
          <div class="col-lg-3 col-md-6 col-12">
            <!-- Single Widget -->
            <div class="single-footer f-contact">
              <h3>Contact</h3>
              <ul>
                <li>23 New Design Str, Lorem Upsum 10<br> Hudson Yards, USA</li>
                <li>Tel. +(123) 1800-567-8990 <br> Mail. support@classigrids.com</li>
              </ul>
            </div>
            <!-- End Single Widget -->
          </div>
        </div>
      </div>
    </div>
    <!--/ End Footer Middle -->
    <!-- Start Footer Bottom -->
    <div class="footer-bottom">
      <div class="container">
        <div class="inner">
          <div class="row">
            <div class="col-12">
              <div class="content">
                <ul class="footer-bottom-links">
                  <li><a href="">Terms of use</a></li>
                  <li><a href=""> Privacy Policy</a></li>
                  <li><a href="">Advanced Search</a></li>
                  <li><a href="">Site Map</a></li>
                  <li><a href="">Information</a></li>
                </ul>
                <ul class="footer-social">
                  <li><a href=""><i class="lni lni-facebook-filled"></i></a></li>
                  <li><a href=""><i class="lni lni-twitter-original"></i></a></li>
                  <li><a href=""><i class="lni lni-youtube"></i></a></li>
                  <li><a href=""><i class="lni lni-linkedin-original"></i></a></li>
                </ul>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
    <!-- End Footer Middle -->
  </div>
</template>

<script>
export default {
  name: 'footer'
}
</script>

<style scoped>

</style>
