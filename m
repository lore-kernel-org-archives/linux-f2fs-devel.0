From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 1/1] f2fs: sanity check checkpoint segno and blkoff
Date: Fri, 12 May 2017 08:19:08 +0200
Message-ID: <20170512061908.GA5866@kroah.com>
References: <20170512002420.25065-1-jinqian@android.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170512002420.25065-1-jinqian@android.com>
Sender: stable-owner@vger.kernel.org
To: Jin Qian <jinqian@google.com>
Cc: linux-f2fs-devel@lists.sourceforge.net, jaegeuk@kernel.org, stable@vger.kernel.org, Jin Qian <jinqian@android.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

On Thu, May 11, 2017 at 05:24:20PM -0700, Jin Qian wrote:
> Make sure segno and blkoff read from raw image are valid.
> 
> Signed-off-by: Jin Qian <jinqian@android.com>
> ---
>  fs/f2fs/super.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)

<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read Documentation/stable_kernel_rules.txt
for how to do this properly.

</formletter>
