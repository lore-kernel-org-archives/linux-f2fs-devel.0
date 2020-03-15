Return-Path: <SRS0=4zR2=5A=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EE21C18E5B
	for <linux-f2fs-devel@archiver.kernel.org>; Sun, 15 Mar 2020 19:05:48 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E1C1920578;
	Sun, 15 Mar 2020 19:05:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="LMvp+v2z";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="UvY1wxW7";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="CWG1DXII"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1C1920578
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1jDYa3-0007uK-Eq; Sun, 15 Mar 2020 19:05:47 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <ebiggers@kernel.org>) id 1jDYa2-0007uC-Es
 for linux-f2fs-devel@lists.sourceforge.net; Sun, 15 Mar 2020 19:05:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=3e+uaAC5S37Q58LRZ+1Ck+tbPih/61TwVax9DFad6pM=; b=LMvp+v2z6Dia9Rpp7MaIdhMqrm
 gQWmwjCtW6xARL0GiliZRBlV7ZeafoS/bbdpd0ZfTeyGllqsq1W7Bcuav8ZJwWUIlvJNiIbAqMSVc
 RJvW4d55lXP+Z9ocTzcYePPrJ890o3fsjtvH6jVLe7l9fBhv5Xi7QrqEXLCP5hyVFPQo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=3e+uaAC5S37Q58LRZ+1Ck+tbPih/61TwVax9DFad6pM=; b=UvY1wxW7xytl7yWtr++OLlIM6j
 i62eQdcuP8CcoqYjmjaFN2t51jg9G43o1H+BGzOfeQysVqJDIGrdaiPKpmfYSdy2wBzFk7MvakiYi
 hdEzruTmY7ZZhz0wKSkulWrpm5H0Ui3+uo7QaziUGjIrEHx3wcAD4JPb+yoDgLWsIiLI=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1jDYZv-008GSE-MJ
 for linux-f2fs-devel@lists.sourceforge.net; Sun, 15 Mar 2020 19:05:46 +0000
Received: from sol.localdomain (c-107-3-166-239.hsd1.ca.comcast.net
 [107.3.166.239])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id CC79320578;
 Sun, 15 Mar 2020 19:05:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1584299134;
 bh=AROhWcVtzfvvJB4CmqG3BffPRTtIFHTnvTYp7D8oZWI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=CWG1DXIIbJFn0UI3IHBzXhaCpia54a34w1SspqZ/cD2E1DVYbR468krQv4D2xwpE9
 Gx3pXmsE8+Zkj36nuZbY9f9a3EntRie4npqs4j9e36G2n+mksxL/yEVqyFLjEajxjC
 RI4kj2kKGG/PxJKcmds1gsrgaQmNQtLl7jRvTtuQ=
Date: Sun, 15 Mar 2020 12:05:32 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Satya Tangirala <satyat@google.com>
Message-ID: <20200315190532.GF1055@sol.localdomain>
References: <20200312080253.3667-1-satyat@google.com>
 <20200312080253.3667-9-satyat@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200312080253.3667-9-satyat@google.com>
X-Headers-End: 1jDYZv-008GSE-MJ
Subject: Re: [f2fs-dev] [PATCH v8 08/11] fs: introduce SB_INLINECRYPT
X-BeenThere: linux-f2fs-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: linux-scsi@vger.kernel.org, Kim Boojin <boojin.kim@samsung.com>,
 Kuohong Wang <kuohong.wang@mediatek.com>,
 Barani Muthukumaran <bmuthuku@qti.qualcomm.com>,
 linux-f2fs-devel@lists.sourceforge.net, linux-block@vger.kernel.org,
 linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Thu, Mar 12, 2020 at 01:02:50AM -0700, Satya Tangirala wrote:
> Introduce SB_INLINECRYPT, which is set by filesystems that wish to use
> blk-crypto for file content en/decryption.
> 
> Signed-off-by: Satya Tangirala <satyat@google.com>
> ---
>  fs/proc_namespace.c | 1 +
>  include/linux/fs.h  | 1 +
>  2 files changed, 2 insertions(+)
> 
> diff --git a/fs/proc_namespace.c b/fs/proc_namespace.c
> index 273ee82d8aa9..8bf195d3bda6 100644
> --- a/fs/proc_namespace.c
> +++ b/fs/proc_namespace.c
> @@ -49,6 +49,7 @@ static int show_sb_opts(struct seq_file *m, struct super_block *sb)
>  		{ SB_DIRSYNC, ",dirsync" },
>  		{ SB_MANDLOCK, ",mand" },
>  		{ SB_LAZYTIME, ",lazytime" },
> +		{ SB_INLINECRYPT, ",inlinecrypt" },
>  		{ 0, NULL }
>  	};
>  	const struct proc_fs_info *fs_infop;
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 3cd4fe6b845e..08a0395674dd 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -1370,6 +1370,7 @@ extern int send_sigurg(struct fown_struct *fown);
>  #define SB_NODIRATIME	2048	/* Do not update directory access times */
>  #define SB_SILENT	32768
>  #define SB_POSIXACL	(1<<16)	/* VFS does not apply the umask */
> +#define SB_INLINECRYPT	(1<<17)	/* inodes in SB use blk-crypto */

"inodes use blk-crypto" isn't very clear.  It could be misunderstand as meaning
something like "does the filesystem contain any encrypted files".  I think the
following would be a bit clearer:

	/* Use blk-crypto for encrypted files */

(And these flags are obviously per-sb, so there's no need to write "in SB".)


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
