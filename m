From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH] f2fs: get victim segment again after new cp
Date: Thu, 21 Jul 2016 09:44:49 -0700
Message-ID: <20160721164449.GA812@jaegeuk>
References: <1469107829-20459-1-git-send-email-heyunlei@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1bQH5l-0003Iw-Th
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 21 Jul 2016 16:44:57 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1bQH5j-0002QW-SI
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 21 Jul 2016 16:44:57 +0000
Content-Disposition: inline
In-Reply-To: <1469107829-20459-1-git-send-email-heyunlei@huawei.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Yunlei He <heyunlei@huawei.com>
Cc: yuchao@huawei.com, linux-f2fs-devel@lists.sourceforge.net

Hi Yunlei,

The problem may be the above stale segno.
How about this?

---
 fs/f2fs/gc.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index de6c41c..8a0ed89 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -908,10 +908,12 @@ gc_more:
 		 * enough free sections, we should flush dent/node blocks and do
 		 * garbage collections.
 		 */
-		if (__get_victim(sbi, &segno, gc_type) || prefree_segments(sbi))
+		if (__get_victim(sbi, &segno, gc_type) || prefree_segments(sbi)) {
+			segno = NULL_SEGNO;
 			write_checkpoint(sbi, &cpc);
-		else if (has_not_enough_free_secs(sbi, 0))
+		} else if (has_not_enough_free_secs(sbi, 0)) {
 			write_checkpoint(sbi, &cpc);
+		}
 	}
 
 	if (segno == NULL_SEGNO && !__get_victim(sbi, &segno, gc_type))
-- 
2.8.3

On Thu, Jul 21, 2016 at 09:30:29PM +0800, Yunlei He wrote:
> previous segment selected may become free after write_checkpoint,
> so here, we select victim again.
> 
> Signed-off-by: Yunlei He <heyunlei@huawei.com>
> ---
>  fs/f2fs/gc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
> index de6c41c..704e2e1 100644
> --- a/fs/f2fs/gc.c
> +++ b/fs/f2fs/gc.c
> @@ -914,7 +914,7 @@ gc_more:
>  			write_checkpoint(sbi, &cpc);
>  	}
>  
> -	if (segno == NULL_SEGNO && !__get_victim(sbi, &segno, gc_type))
> +	if (!__get_victim(sbi, &segno, gc_type) && segno == NULL_SEGNO)
>  		goto stop;
>  	ret = 0;
>  
> -- 
> 1.9.1

------------------------------------------------------------------------------
What NetFlow Analyzer can do for you? Monitors network bandwidth and traffic
patterns at an interface-level. Reveals which users, apps, and protocols are 
consuming the most bandwidth. Provides multi-vendor support for NetFlow, 
J-Flow, sFlow and other flows. Make informed decisions using capacity planning
reports.http://sdm.link/zohodev2dev
