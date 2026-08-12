Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9409C5AD5A
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 12 Aug 2026 09:30:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=STMi5rVH292VUXtWSKZk5bro72TaOvWyDlOnaAAv9Qo=; b=FiI92renL5enzwFFwL+IcFrZjH
	lTiM4sR18ehhClzSk18jnWZufl+RBL0weTUBKiv0RkC/Mr2AKxe+K04+Mvfwu82kf/PcV5yNVZgy5
	i5Hrp2rANikJ/0h5+3ZJ99MA0ibtBew9NmUW4LAJHEtO0QeY7GrFIvGeRXzu/Bdy2QFw=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wu5IF-0001Se-Ss;
	Wed, 12 Aug 2026 09:30:37 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1wu5IE-0001SW-1y
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 12 Aug 2026 09:30:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=sCNy7bwSl7GQs5/Abl5un/U19S8NKl7KYsInH1bT2Cw=; b=OmiAz3tvyybhyYqgI1j8iK7KG2
 CbXXLpJ1vaEN/qonQZmaa+bvrpFcsCvFaqsu7NA54nUY30ADCRX4MaMpbcjAGdu0eUxNV3uG4hSZR
 blp+csVejuJO2RGYErud5Y9JPAOoMvVb+JhDJ9hj8XyQ54HDjAHeZJZDDZHVzcZTSS64=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=sCNy7bwSl7GQs5/Abl5un/U19S8NKl7KYsInH1bT2Cw=; b=eQKvbLEJP7CKkcyISkGAnQli1I
 rY7iHQI1rN2qLwC38+PL+R8unxKNc3su3LHbYPECjmjhJQByXAUoC3/5Abxapn9DdCHZYhxkFhOO/
 rcDhrEnYkWxjWYIfwDdJOrWDdmsOLcBn2IOuXuFBpsCd+Slgkn5p7v5NFE33ubZsxC60=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wu5ID-0005VE-GO for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 12 Aug 2026 09:30:35 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 8C42E415CA;
 Wed, 12 Aug 2026 09:30:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2200F1F00A3A;
 Wed, 12 Aug 2026 09:30:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786527028;
 bh=sCNy7bwSl7GQs5/Abl5un/U19S8NKl7KYsInH1bT2Cw=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To;
 b=Lo5R6OaamcQYN8WgvHhxuzmC4u4UKBsCcC4IF6ADiGzMveMSAfwYElX8lgwVsz0kf
 B4f2W7PjM4KETJ7KnQnwvrqR5W4mBbyafq8vFbFzzCM19QnLn+NsAiIj1gld9AjG0r
 RvK3QX0yb0H3zEm5v5xNCBZ+3C+JohoVBjbtFDN3rLF+3W+Rltb2n7xZ1jou4PQIWP
 9TbozClEMsOtCRd2THqjOXl1kpYiGPgUnOEmGfJY2jJWvgqgBNNt62Sfk5G84B74yP
 M+BoVPaDWbqlRuX1uViNzCZPx8Zljg5jDk+TaQLy6fa9LQAmn0nGd9mgm3PS4CJKxS
 rQsmy/Lx1/RmQ==
Message-ID: <c9a95043-f4bb-403b-8603-b65c703e037c@kernel.org>
Date: Wed, 12 Aug 2026 17:30:25 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Wenjie Qi <qwjhust@gmail.com>, jaegeuk@kernel.org
References: <20260810133832.3530016-1-qiwenjie@xiaomi.com>
Content-Language: en-US
In-Reply-To: <20260810133832.3530016-1-qiwenjie@xiaomi.com>
X-Headers-End: 1wu5ID-0005VE-GO
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: return symlink writeback errors
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
Cc: stable@kernel.org, qiwenjie@xiaomi.com, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 8/10/26 21:38, Wenjie Qi wrote:
> F2FS writes long symlink data with page_symlink() and then flushes the
> symlink mapping to reduce the chance of exposing a broken symlink.
> 
> That flush result is currently ignored. If the writeback fails, symlink()
> still returns success even though the symlink is not durable and the same
> operation can already surface -EIO through syncfs().
> 
> Return the writeback error to userspace and skip the dirsync flush once the
> symlink data flush has failed.
> 
> Fixes: d0cae97cb600 ("f2fs: flush symlink path to avoid broken symlink after POR")
> Cc: stable@kernel.org
> Signed-off-by: Wenjie Qi <qiwenjie@xiaomi.com>
Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
