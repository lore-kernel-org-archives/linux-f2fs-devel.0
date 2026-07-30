Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03360C54FCD
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 30 Jul 2026 02:41:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:
	Message-ID:Date:To:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=aeT32+vACpThHXGLpdhTmqvTU4RfsrcO9+ic2vWcnUg=; b=YVsg46MSeGB7yoJtPDq4blwW+L
	cZmmAXwqNcV6jFQBXSToXHkuG43TPLMb6x3WMw0qkHN22s1zyigYFOwhidFitYXk+QOsiL8MuU2TJ
	YzGVe8fCjlY/Ws8xdx+eZJwem/+54c/HCVpQVBoC+iaEzgw6MJgvbIuYSn6LxLIU1Y2k=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wpGhk-0006zr-3m;
	Thu, 30 Jul 2026 02:41:04 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <sashal@kernel.org>) id 1wpGha-0006zU-Iy
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 30 Jul 2026 02:40:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=wWOaXmuyFqvGmfMPmTXpsA6I5Il6YtpMCom9kc1QjTM=; b=Fdd+04HbzTP6mhFeA5ZMQyV0cm
 y9AqU7cfNcfWz3KLQlHRLXS9F0LnrYwytMn7YsnqL7AsTCkAZdiiT8KUn2C0TQ62ETCTmMS5nFDWh
 7VLAl8kkO54+Iq2BGKc1iDgpuFS75b+LUWAPkwjdtRjq6Y0gbBNpqRmxfyIPVce1DoyQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=wWOaXmuyFqvGmfMPmTXpsA6I5Il6YtpMCom9kc1QjTM=; b=UGPP/3kC4/ut8aNMKpfVYcm4i2
 rxnUTT62QntM5BCjlkj3p6WCckpIQ1sN/HaLRg73MF0TIZTFJgNmkPFPqWCWb7jOljYt0mUZvcfUh
 0MDdeS+lBBehjP1wn4TYJ/UmXMh9hR5vcwkLwqvMs3778qtt7GpOJROjIQPAxo7zjffE=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wpGhd-0008Ly-N8 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 30 Jul 2026 02:40:54 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 99D3043EEF;
 Thu, 30 Jul 2026 02:40:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD1071F000E9;
 Thu, 30 Jul 2026 02:40:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785379248;
 bh=wWOaXmuyFqvGmfMPmTXpsA6I5Il6YtpMCom9kc1QjTM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=C38+LAkkMr9l2lFhxwNr+xn0l+6DtqqU2Wc6jY1CUmDJ4J9efzReT0CzvDUNAWBBF
 pGvXP9om6Pzxws9fI16n03GYqVnR6hxuGmVJFTPvGQpeSmDVPjanw4GULAWpVpyZQo
 vDWoGZdEDYx68J8hz1pt6I/4qFucdCZZqAoe63AP4XS7K1+Nrvn75+d4rKKz4MCmrc
 EH130k51KO207YFegTAeAVZ2VIrT3fHhK12Wgdm9Nlg7oNmO8AdiYhIxZ1i67u+ymy
 l0U4F/xnurJhHfiLzR29iqk+3KEg/hY5P5p2/48wYhhguFnMrCxvR7AOLrNL4bSq8a
 ksuk9PHovbahg==
To: stable@vger.kernel.org
Date: Wed, 29 Jul 2026 22:40:14 -0400
Message-ID: <20260729223316.stable-0018@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260729151905.8303-1-ebiggers@kernel.org>
References: <20260729151905.8303-1-ebiggers@kernel.org>
MIME-Version: 1.0
X-Headers-End: 1wpGhd-0008Ly-N8
Subject: Re: [f2fs-dev] [PATCH 6.18] fscrypt: Avoid dynamic allocation in
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

> [PATCH 6.18] fscrypt: Avoid dynamic allocation in fscrypt_get_devices()

Queued for 6.18, thanks.

-- 
Thanks,
Sasha


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
