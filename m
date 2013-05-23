From: Jason Hrycay <jhrycay@gmail.com>
Subject: Re: [f2fs-dev] [PATCH 3/4] f2fs: return proper error from
	start_gc_thread
Date: Thu, 23 May 2013 09:32:30 -0500
Message-ID: <519E287E.4010307@gmail.com>
References: <1369317502-14380-1-git-send-email-linkinjeon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jhrycay@gmail.com>) id 1UfWZL-0006Bj-5g
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 23 May 2013 14:32:39 +0000
Received: from mail-ie0-f182.google.com ([209.85.223.182])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1UfWZJ-00025Q-SO
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 23 May 2013 14:32:39 +0000
Received: by mail-ie0-f182.google.com with SMTP id a14so8824324iee.41
	for <linux-f2fs-devel@lists.sourceforge.net>;
	Thu, 23 May 2013 07:32:32 -0700 (PDT)
In-Reply-To: <1369317502-14380-1-git-send-email-linkinjeon@gmail.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Namjae Jeon <linkinjeon@gmail.com>
Cc: Amit Sahrawat <a.sahrawat@samsung.com>, Namjae Jeon <namjae.jeon@samsung.com>, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, jason.hrycay@motorola.com, linux-fsdevel@vger.kernel.org

On 5/23/2013 8:58 AM, Namjae Jeon wrote:
> From: Namjae Jeon <namjae.jeon@samsung.com>
> 
> when there is an error from kthread_run, then return proper error
> rather than returning -ENOMEM.
> 
> Signed-off-by: Namjae Jeon <namjae.jeon@samsung.com>
> Signed-off-by: Amit Sahrawat <a.sahrawat@samsung.com>
> ---
>  fs/f2fs/gc.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
> index 25b083c..03d5ba1 100644
> --- a/fs/f2fs/gc.c
> +++ b/fs/f2fs/gc.c
> @@ -105,7 +105,7 @@ int start_gc_thread(struct f2fs_sb_info *sbi)
>  	if (IS_ERR(gc_th->f2fs_gc_task)) {
>  		kfree(gc_th);

gc_th is free'd here, save off PTR_ERR result to avoid use-after-free?

>  		sbi->gc_thread = NULL;
> -		return -ENOMEM;
> +		return PTR_ERR(gc_th->f2fs_gc_task);
>  	}
>  	return 0;
>  }
> 

--
Jason Hrycay

------------------------------------------------------------------------------
Try New Relic Now & We'll Send You this Cool Shirt
New Relic is the only SaaS-based application performance monitoring service 
that delivers powerful full stack analytics. Optimize and monitor your
browser, app, & servers with just a few lines of code. Try New Relic
and get this awesome Nerd Life shirt! http://p.sf.net/sfu/newrelic_d2d_may
