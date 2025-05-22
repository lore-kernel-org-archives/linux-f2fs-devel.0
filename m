Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FDADC54756
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 22 May 2025 03:42:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=N+JugRjReSYvgLoACh7/OaOIQAm90ai2Bvc2KehupCA=; b=E/lWWCFFN1VXncfse1XbpSC/Nf
	cVF7RO48vVYgsk3Ev+OIMZUFYexSqIOkYJ2pPYJRSC3tSM4UH5SnKCPzUp+elhu2XKX+Qa7QaTRsr
	bF5cTwYFbHgOJUlQecb96unQ4BPEcniuQ/reomQt6Hyl0g0GtwmgfaOXWHsnn56wuLKM=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1uHwpL-00020q-8S;
	Thu, 22 May 2025 03:42:39 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1uHwpJ-00020j-G7
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 22 May 2025 03:42:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=wO7o3zLzNh8RXQIfg7bXX1K+4PmU2ZxlV4iBoMjeOuk=; b=kPNaDuJuXGaFF+mANxDlWiYs6q
 Vg4cqDYuL/mc8y5A6df/mkCOCm9fZ7Fr4vGs/LZ8f9k9+nsq/3QMVsEwymYEV/Z78fooIzRnaJD50
 VESKo6Bzuwu6A6r9lv3x1oUZfDnpO20Dg8w8jR8yVQTXGuJSUUSi6PhCvf8NU/fJA1U0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=wO7o3zLzNh8RXQIfg7bXX1K+4PmU2ZxlV4iBoMjeOuk=; b=m4VUpzzvmduyJLvli78XN2jR5t
 0+7jjrjthA8s/9ZuykPF4MIkUtJhlM8NJEmynF7On1A8ABvdJ8e0HzUnNy/xJ77kiLz+/h7FPe7w0
 KA+A3XTltWAIPud5BxFEI1kdm+6DzvBNuDDw43vAK595tffKUbOadw3XbHZ4X8FIxSnY=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1uHwpJ-0002nT-0b for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 22 May 2025 03:42:37 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id A5E6F44F27;
 Thu, 22 May 2025 03:42:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76C3AC4CEE4;
 Thu, 22 May 2025 03:42:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1747885346;
 bh=bsn80ptBahLUmBO/dtkU23IoT5OpZGzqYExsYdH/EFM=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
 b=sMP6HryqYnNzLHziP5+B3zXjkbh7UPfebI7ieAuhkQfj1kUwWzQrmSqsTDTthgR0Q
 aIkMcoSTnICgOQCA53wgKOBGAepByDRK77auDlR2xM21U5hLnSCVvx2CtBIWsgYGzb
 jkzObw7ZmGs4ZE0QquzCSW3XOICMgD+7MtS//OPFUubd3hcVG6yO5bOuZ3NbIv11Fb
 KoXzPUoYYi/sgmp3v9C99OpLs84w0dKXAzNhngnkB0czbamjE+rqAOO41t4dz7rC76
 mAc+BoBf7WsmGCN/wFrCvFfd8Z7JMP3w9HnMpSFA48GHsQrXz1gzZiUYtuEvAufC8r
 pipGM+3LWXRzQ==
Message-ID: <d98160d7-f128-4acc-8b4c-a33ce0cbb7bf@kernel.org>
Date: Thu, 22 May 2025 11:42:23 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Daeho Jeong <daeho43@gmail.com>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
References: <20250521194100.1407220-1-daeho43@gmail.com>
Content-Language: en-US
In-Reply-To: <20250521194100.1407220-1-daeho43@gmail.com>
X-Headers-End: 1uHwpJ-0002nT-0b
Subject: Re: [f2fs-dev] [PATCH] fsck.f2fs: fix null buffer error with
 dev_fill
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
Cc: Daeho Jeong <daehojeong@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 5/22/25 03:41, Daeho Jeong wrote:
> From: Daeho Jeong <daehojeong@google.com>
> 
> Make fsck use dev_fill_block() with zeroed buffer instead of dev_fill().
> 
> Signed-off-by: Daeho Jeong <daehojeong@google.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
