Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08C66C55165
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 30 Jul 2026 02:41:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:
	Message-ID:Date:To:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=apuOgMAi6hsFrw9cSlUUnrbG2X/w5EEzCEIauGPtHZo=; b=BC2dh30YIFH/6lEm0Y2XM8YBjy
	o5xkseYu0TyNpEU0/NEl6RbzhgDPvJMdYtJy0FmQPiHJzylZzVFcQkIHDqpO4BIbTbcMuQiborldd
	cOJNgKk3BjNjGcvX9pEKp3YRlq6GqIoIIlmvTjGBc52GB2TS50PgGMUOcLMvk8fc48rs=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wpGhq-0002od-2u;
	Thu, 30 Jul 2026 02:41:07 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <sashal@kernel.org>) id 1wpGhd-0002o4-Le
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 30 Jul 2026 02:40:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=QLVH5gwjjQR7h/ReEB35nFfhA+98Zkl6i4fNXBvQ5q8=; b=UwJstpiCMV2EpEooDnB1qIevxr
 7Xmlv288saWaJ4l0h90GdT/dTlm01r0afMff0sIRL9+dxRy192K1CSbpDfFwLMHkXAVyrmgnJ14Nb
 TJTv/fe6XwV8RzSkf2jnwb5yTDtF92qeY65DsAi/rlimaJLwtceyqYhS+FSIJrDr++to=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=QLVH5gwjjQR7h/ReEB35nFfhA+98Zkl6i4fNXBvQ5q8=; b=Fr3p68D547Y6BOW2y0GikwSHnt
 dsjBhRNqkq58bbr49ZroJmnHbuAUPi2QdC+9psa+EhqT2xoP59pDZvyDDn0nKvILzZWNiW0pMytwk
 sgKMYSNxkc2e5kvyiljtpQrA3jQ42H1OjBBxKgZ35C/RHZbQRkA1wOatbvjpjF3LLpMk=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wpGha-0001lN-R2 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 30 Jul 2026 02:40:55 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 89AB343EFC;
 Thu, 30 Jul 2026 02:40:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD28B1F00A3D;
 Thu, 30 Jul 2026 02:40:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785379249;
 bh=QLVH5gwjjQR7h/ReEB35nFfhA+98Zkl6i4fNXBvQ5q8=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=KJvuW95dw1ejoGKeX+FTCT2/WcivxoaJuPQyD+a6288PSZqP2cf+s6UY9rtcp+ypD
 yo5cVAOxJdE/LDFJRMB74Jb8pBunH7BTPIwNv51pbOVei7n+zA+YA6KexsS8h60PDC
 hcyFeqpoJzPcKjNXaFb/XOFuGm1+mhFO1csYTfJcQ9cBL0pTQ83/LlV125P1HhPjM5
 kfsTVpmHezmYQZrdAg+UwMFNgVbN09TaiAqsqG+k7JOMsQE8LE05DShn/+rCRfH0xx
 fnVGr+Jqd15EMTCLlM38+pt4Sv/N8OUCgH1xMF6/xECSE3Foqy6HmwKcKlcL5i8gSq
 UVmtrYH7abs/A==
To: stable@vger.kernel.org
Date: Wed, 29 Jul 2026 22:40:15 -0400
Message-ID: <20260729223316.stable-0019@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260729152127.11918-1-ebiggers@kernel.org>
References: <20260729152127.11918-1-ebiggers@kernel.org>
MIME-Version: 1.0
X-Headers-End: 1wpGha-0001lN-R2
Subject: Re: [f2fs-dev] [PATCH 6.12] fscrypt: Avoid dynamic allocation in
 fscrypt_get_devices()
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
From: Sasha Levin via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Sasha Levin <sashal@kernel.org>
Cc: Sasha Levin <sashal@kernel.org>, Eric Biggers <ebiggers@kernel.org>,
 linux-fscrypt@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

> [PATCH 6.12] fscrypt: Avoid dynamic allocation in fscrypt_get_devices()

Queued for 6.12, thanks.

-- 
Thanks,
Sasha


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
