From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH -v2] f2fs: Remove lock from check_valid_map
Date: Sun, 7 Sep 2014 20:50:24 -0700
Message-ID: <20140908035024.GA13009@jaegeuk-mac02.hsd1.ca.comcast.net>
References: <1410059104-9060-1-git-send-email-ying.huang@intel.com>
	<1410061110-31081-1-git-send-email-ying.huang@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1XQpyI-00040V-KB
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 08 Sep 2014 03:50:30 +0000
Received: from mail.kernel.org ([198.145.19.201])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1XQpyH-0003p8-N8 for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 08 Sep 2014 03:50:30 +0000
Content-Disposition: inline
In-Reply-To: <1410061110-31081-1-git-send-email-ying.huang@intel.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Huang Ying <ying.huang@intel.com>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

Hi,

On Sun, Sep 07, 2014 at 11:38:30AM +0800, Huang Ying wrote:
> Only one bit is read in check_valid_map, holding a lock to do that
> doesn't help anything except decreasing performance.
> 
> Signed-off-by: Huang, Ying <ying.huang@intel.com>
> ---
> 
> v2: Fixed a build warning.
> 
> ---
>  fs/f2fs/gc.c |    3 ---
>  1 file changed, 3 deletions(-)
> 
> --- a/fs/f2fs/gc.c
> +++ b/fs/f2fs/gc.c
> @@ -378,14 +378,11 @@ static void put_gc_inode(struct list_hea
>  static int check_valid_map(struct f2fs_sb_info *sbi,
>  				unsigned int segno, int offset)
>  {
> -	struct sit_info *sit_i = SIT_I(sbi);
>  	struct seg_entry *sentry;
>  	int ret;
>  
> -	mutex_lock(&sit_i->sentry_lock);
>  	sentry = get_seg_entry(sbi, segno);
>  	ret = f2fs_test_bit(offset, sentry->cur_valid_map);
> -	mutex_unlock(&sit_i->sentry_lock);
>  	return ret;

The f2fs_test_bit is not atomic, so I'm not sure this is a good approach.
How about introducing rw_semaphore?

>  }
>  

------------------------------------------------------------------------------
Want excitement?
Manually upgrade your production database.
When you want reliability, choose Perforce
Perforce version control. Predictably reliable.
http://pubads.g.doubleclick.net/gampad/clk?id=157508191&iu=/4140/ostg.clktrk
