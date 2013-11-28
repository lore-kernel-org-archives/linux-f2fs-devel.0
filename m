From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: f2fs: introduce f2fs_issue_discard() to clean up
Date: Thu, 28 Nov 2013 11:08:52 +0300
Message-ID: <20131128080852.GD5443@mwanda>
References: <20131126145315.GA27436@elgon.mountain>
	<1385520381.2417.17.camel@kjgkr> <20131127083117.GT5443@mwanda>
	<1385543097.2417.35.camel@kjgkr> <20131127104130.GW5443@mwanda>
	<1385611487.2417.40.camel@kjgkr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <dan.carpenter@oracle.com>) id 1Vlwer-0008AA-T2
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 28 Nov 2013 08:09:09 +0000
Received: from userp1040.oracle.com ([156.151.31.81])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Vlwer-0005w0-1P
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 28 Nov 2013 08:09:09 +0000
Content-Disposition: inline
In-Reply-To: <1385611487.2417.40.camel@kjgkr>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Jaegeuk Kim <jaegeuk.kim@samsung.com>
Cc: linux-f2fs-devel@lists.sourceforge.net

On Thu, Nov 28, 2013 at 01:04:47PM +0900, Jaegeuk Kim wrote:
> diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
> index b7ad1ec..5fa54c1 100644
> --- a/fs/f2fs/gc.c
> +++ b/fs/f2fs/gc.c
> @@ -664,8 +664,6 @@ static void do_garbage_collect(struct f2fs_sb_info
> *sbi, unsigned int segno,
>  
>  	/* read segment summary of victim */
>  	sum_page = get_sum_page(sbi, segno);
> -	if (IS_ERR(sum_page))
> -		return;

Didn't you want to check for NULL here?

regards,
dan carpenter

>  
>  	blk_start_plug(&plug);
>  


------------------------------------------------------------------------------
Rapidly troubleshoot problems before they affect your business. Most IT 
organizations don't have a clear picture of how application performance 
affects their revenue. With AppDynamics, you get 100% visibility into your 
Java,.NET, & PHP application. Start your 15-day FREE TRIAL of AppDynamics Pro!
http://pubads.g.doubleclick.net/gampad/clk?id=84349351&iu=/4140/ostg.clktrk
