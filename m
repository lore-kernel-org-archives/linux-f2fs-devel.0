Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A7CACD98C5
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 15 Jun 2026 03:14:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=U7vnMpH9B3fPz+YM6jffH5zXQnPjaDH1yZaioFTqhFs=; b=a0ZuO2ntT9Gt+s0kyCjRfIMkqs
	PnZQdPJtZYMCm02LqQ4fI5qdx2UfQAiLOzCIUbAknuZuD8LMHoMm0WWOBxb1pfLs1FIojNnR2P+IL
	74Kqp3pP6ClY68s7ctYgKUdskp3jqWyKKqIMAUqORA5LBcC3+uPV5MRwjXPlIkLbXpWg=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wYxmL-0002XV-84;
	Mon, 15 Jun 2026 03:14:22 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1wYxmJ-0002XN-6U
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 15 Jun 2026 03:14:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=m8p1sEGL+W1L0l6iKEoOSB+rXixXbnsVyCjzmpVoam0=; b=I3fG3NkzrkhaLKCyOOlmohaPF2
 +359aDVY5Co7pBaSl2yjTNo5gi2S4ORe2p7BU0/lE5JaSYegmz07Vwtb1BSQr3QCX+dMXlStWN30f
 Z5gfLVBAt/EJsKKB9msRFpdeltfyBHBsqaPfUiaZyUdAltswYew4CUSZODxgG8f7q2Zs=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=m8p1sEGL+W1L0l6iKEoOSB+rXixXbnsVyCjzmpVoam0=; b=Qn286Ls51aOYKwvz2ZwXGejbeh
 G+BQfK2yZehj8HZ2hlKqzKC83GEaaQMQ0ukhxqiqQGorY8b3MOcyBT+2gbQAskM/lk59lS2Dn00Ek
 640qzgAS0P/I6bsLChy2OP+9GEQpRu/oGLNlw2pKkH2Yc5C5o0+zKkMtEUSdbyurwRJc=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wYxmE-00089Z-Pv for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 15 Jun 2026 03:14:20 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 4B6B16008A;
 Mon, 15 Jun 2026 03:14:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A96821F000E9;
 Mon, 15 Jun 2026 03:14:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781493247;
 bh=m8p1sEGL+W1L0l6iKEoOSB+rXixXbnsVyCjzmpVoam0=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To;
 b=eIMhx9Urd+AE8bQq+bKCn3TPJa96gOWFy+mTz1lQMyRxlCQSsr3EQXOZKIfNr+CwR
 TaJp7tedSsX1j6ZztZc5NfFzpo0LDUrBPkBgPpmbcQdRykaQsNXYTHRvGzOQz4kKb0
 I0GBvfpMiekFj+E30As051xhyYAgMLVObAu2wshcWoSa8MXQForsit9Sina9DwPbHn
 3VrM1q/g9m9dOAkOGBhTYa23hAJnRgHJRhrlRcwQvCdg49owHXgkhyalAOJnOOJQDK
 EAmB+Ac2jhgWM4l+jo1lhxX/PEj83daWv9K88PV1CyEkEQha8KTuJjQIg7pKCXuksH
 1krdrhJHpNf/g==
Message-ID: <e7ff2e57-b81f-4195-8e33-062e77b080fe@kernel.org>
Date: Mon, 15 Jun 2026 11:14:04 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Samuel Moelius <sam.moelius@trailofbits.com>,
 Jaegeuk Kim <jaegeuk@kernel.org>
References: <20260603154933.16368-1-sam.moelius@trailofbits.com>
Content-Language: en-US
In-Reply-To: <20260603154933.16368-1-sam.moelius@trailofbits.com>
X-Headers-End: 1wYxmE-00089Z-Pv
Subject: Re: [f2fs-dev] [PATCH] f2fs: validate inline dentry name lengths
 before conversion
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
From: Chao Yu via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Chao Yu <chao@kernel.org>
Cc: open list <linux-kernel@vger.kernel.org>,
 "open list:F2FS FILE SYSTEM" <linux-f2fs-devel@lists.sourceforge.net>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 6/3/26 23:49, Samuel Moelius wrote:
> Inline dentry conversion copies names out of the inline dentry area
> before checking that each recorded name length fits in the available
> filename slots.
> 
> A corrupted image can therefore make the conversion path read past
> the inline filename storage while building the regular dentry block.
> 
> Validate each inline dentry name length against the inline filename
> area before copying it.
> 
> Assisted-by: Codex:gpt-5.5-cyber-preview
> Signed-off-by: Samuel Moelius <sam.moelius@trailofbits.com>
> ---
>  fs/f2fs/inline.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/fs/f2fs/inline.c b/fs/f2fs/inline.c
> index 7aabfc9b43cb..4584dfbe3fb8 100644
> --- a/fs/f2fs/inline.c
> +++ b/fs/f2fs/inline.c
> @@ -507,6 +507,10 @@ static int f2fs_add_inline_entries(struct inode *dir, void *inline_dentry)
>  			bit_pos++;
>  			continue;
>  		}
> +		if (unlikely(le16_to_cpu(de->name_len) > F2FS_NAME_LEN ||
> +			     bit_pos + GET_DENTRY_SLOTS(le16_to_cpu(de->name_len)) >
> +			     d.max))
> +			return -EFSCORRUPTED;

	err = -EFSCORRUPTED;
	goto punch_dentry_pages;

Thanks,

>  
>  		/*
>  		 * We only need the disk_name and hash to move the dentry.



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
