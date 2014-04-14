From: Gu Zheng <guz.fnst@cn.fujitsu.com>
Subject: Re: [PATCH 2/7] f2fs: remove the unuseful "issue_tail"
	list
Date: Mon, 14 Apr 2014 09:12:18 +0800
Message-ID: <534B35F2.8000100@cn.fujitsu.com>
References: <5347BAB7.6060306@cn.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <guz.fnst@cn.fujitsu.com>) id 1WZVb7-0004A9-GX
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 14 Apr 2014 01:22:09 +0000
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1WZVb5-00056s-Hc for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 14 Apr 2014 01:22:09 +0000
In-Reply-To: <5347BAB7.6060306@cn.fujitsu.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Kim <jaegeuk.kim@samsung.com>
Cc: fsdevel <linux-fsdevel@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, f2fs <linux-f2fs-devel@lists.sourceforge.net>

Hi All,
There seems to be a mistake in this patch, please ignore it.
I'll send a reworked one later.

Regards,
Gu 
On 04/11/2014 05:49 PM, Gu Zheng wrote:

> With the issue_list and dispatch_list, we can handle flush_merge
> already, so remove the useless "issue_tail" list.
> 
> Signed-off-by: Gu Zheng <guz.fnst@cn.fujitsu.com>
> ---
>  fs/f2fs/f2fs.h    |    1 -
>  fs/f2fs/segment.c |    5 ++---
>  2 files changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index 2ecac83..90109fa 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -358,7 +358,6 @@ struct f2fs_sm_info {
>  	struct flush_cmd *issue_list;		/* list for command issue */
>  	struct flush_cmd *dispatch_list;	/* list for command dispatch */
>  	spinlock_t issue_lock;			/* for issue list lock */
> -	struct flush_cmd *issue_tail;		/* list tail of issue list */
>  };
>  
>  /*
> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> index 524b7ed..8a6fe2a 100644
> --- a/fs/f2fs/segment.c
> +++ b/fs/f2fs/segment.c
> @@ -209,7 +209,7 @@ repeat:
>  	spin_lock(&sm_i->issue_lock);
>  	if (sm_i->issue_list) {
>  		sm_i->dispatch_list = sm_i->issue_list;
> -		sm_i->issue_list = sm_i->issue_tail = NULL;
> +		sm_i->issue_list = NULL;
>  	}
>  	spin_unlock(&sm_i->issue_lock);
>  
> @@ -250,10 +250,9 @@ int f2fs_issue_flush(struct f2fs_sb_info *sbi)
>  
>  	spin_lock(&sm_i->issue_lock);
>  	if (sm_i->issue_list)
> -		sm_i->issue_tail->next = cmd;
> +		sm_i->issue_list->next = cmd;
>  	else
>  		sm_i->issue_list = cmd;
> -	sm_i->issue_tail = cmd;
>  	spin_unlock(&sm_i->issue_lock);
>  
>  	if (!sm_i->dispatch_list)



------------------------------------------------------------------------------
Learn Graph Databases - Download FREE O'Reilly Book
"Graph Databases" is the definitive new guide to graph databases and their
applications. Written by three acclaimed leaders in the field,
this first edition is now available. Download your free book today!
http://p.sf.net/sfu/NeoTech
