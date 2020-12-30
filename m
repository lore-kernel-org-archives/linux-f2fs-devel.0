Return-Path: <SRS0=kJcA=GC=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11D5AC433DB
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 30 Dec 2020 15:56:49 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C00D220575;
	Wed, 30 Dec 2020 15:56:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C00D220575
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kroah.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1kudqC-0005e3-6f; Wed, 30 Dec 2020 15:56:48 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <greg@kroah.com>) id 1kudqA-0005dt-PG
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 30 Dec 2020 15:56:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=InRV2t3SNNnx0dg/YV55vnEea5563XkQ8Wd0NGN+R3E=; b=JrTy470m1pvnG4hMsSCk1WWozC
 lIEzPTE9+8Yt9YI9lJCU1JKWMK1eItuBilbZuAubIQPYpG+M3A14oXmArD4JGLFgpRxKunCqWalag
 Zp9NMOVMCgRJbPx0MFuOTcII+iThuz8PkYAzrQk/DmmnfXoFtDeQPL7yQ7cfIDbdbzao=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=InRV2t3SNNnx0dg/YV55vnEea5563XkQ8Wd0NGN+R3E=; b=QuR8MLM07o8zMJBB9A9wezwrlp
 X+MlhjfKaHcNpEzKpyoXj773AtRnc3EQBtylyp1eCDixybeOlpPKxYSBN1Y9yIVIZPpPlI19IVNYy
 mx1nKfrN5FH12z6pTluwieNdteSUfIJZztdS5WDt1kRQ3UzBYmjG8oCT76Ahub11xGao=;
Received: from out4-smtp.messagingengine.com ([66.111.4.28])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1kudpy-00DFSY-J8
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 30 Dec 2020 15:56:46 +0000
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
 by mailout.nyi.internal (Postfix) with ESMTP id 2A3F85C0126;
 Wed, 30 Dec 2020 10:38:22 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
 by compute5.internal (MEProxy); Wed, 30 Dec 2020 10:38:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=
 date:from:to:cc:subject:message-id:references:mime-version
 :content-type:in-reply-to; s=fm2; bh=InRV2t3SNNnx0dg/YV55vnEea55
 63XkQ8Wd0NGN+R3E=; b=GPBardpKLEh2z1uzWPRP+tgWvEqjk7ksnQyhmDVBoxj
 nW/wCS7TnLggbjCGqLQ/tfAG+TIxbCz17SG2wOO6Xty+4EELhGZc85EGSc9SX0cP
 bKlgrjakgKyZL9B99hxldJDV31AWHFKdEJV9Bbx8atatPCm2TtORKONcGfRMQ/ce
 RQvngOP2g9OfUFOFi9kttiExMDUuIu4X4CInI7KD4aVIELWr6y317ykEahC1vdsL
 +EwHXs3ypdA0OYjS9DR3ZGJZDa3GoHdWzyOHl0GX8Q/Tji3a6ueSfMCH5nXFW4Lf
 d9nA6w52aXITFTVEJdjmq/uCQ1g7ZxoC8Xom9OMK7cw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to:x-me-proxy
 :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=InRV2t
 3SNNnx0dg/YV55vnEea5563XkQ8Wd0NGN+R3E=; b=Jh7znz4k8pK638beSiZcKY
 hnbeW2eviCnEHu1uOqFEtJNLDZUSVQxyqbxMQXkCstNajXZpv+iLUE/wcS6dZ1we
 71SmL+0cbO5eUncCVlVC+x5R3QWFGL8mj8edd3pHGjCdIAijP5NpdHzbtT0jcsRs
 DymUiek1ZpJsuJ65TCqdk7OnJgYwuExnotDihq/9Gt9Di2cm9GJun8FSsuySo/WE
 QfIFWP4GTKmeBlmLVJOxyNeTs6fNMaSydcJ5aSGf7QhluWfUF+lV+vchPgkC6BbR
 M3XBM0wNlFH03yM4A7ImZE3UJ0gntKJdSpLvM7uFc8NKEptVxRSFiNSylsP31YcA
 ==
X-ME-Sender: <xms:7Z7sX7Nz4-L15lmALMZKoxMLm9S8QeKuMe_0LX7Bo74enEekjZ7cOg>
 <xme:7Z7sX16WREB5KyJl-UVokscOc0lz8BJm_2to6atX_Boj-IQdLcoMPQU5Nc-HywfRC
 wP_hLSfGDw7Hg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrvddvfedgjeekucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhepfffhvffukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefirhgvghcu
 mffjuceoghhrvghgsehkrhhorghhrdgtohhmqeenucggtffrrghtthgvrhhnpeevueehje
 fgfffgiedvudekvdektdelleelgefhleejieeugeegveeuuddukedvteenucfkphepkeef
 rdekiedrjeegrdeigeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
 hlfhhrohhmpehgrhgvgheskhhrohgrhhdrtghomh
X-ME-Proxy: <xmx:7Z7sX3JvGcDgzQudF61rzqfGkl0wyBPXWs09FV3tMJIAJrAZbM2qiw>
 <xmx:7Z7sX3fMt_9mKZI_ZCkgHhA_kxVFdzg4F80PLyxfidBCKxZqnA-WTQ>
 <xmx:7Z7sXycCqMHvvv7nrqXaeuG3Qxe1Rhy2NrPeVuG2wRN21TTGmT8yJw>
 <xmx:7p7sXzLc7QbMMgrw9FJSA2QwD7Nv5dz0f69hS-drTbzNMbNUbi6wQg>
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
 by mail.messagingengine.com (Postfix) with ESMTPA id 1E5BF1080057;
 Wed, 30 Dec 2020 10:38:21 -0500 (EST)
Date: Wed, 30 Dec 2020 16:39:24 +0100
From: Greg KH <greg@kroah.com>
To: Eric Biggers <ebiggers@kernel.org>
Message-ID: <X+yfLAyAw8kOcOGz@kroah.com>
References: <20201228185433.61129-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201228185433.61129-1-ebiggers@kernel.org>
X-Headers-End: 1kudpy-00DFSY-J8
Subject: Re: [f2fs-dev] [PATCH 5.4 0/4] fscrypt: prevent creating duplicate
 encrypted filenames
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
Cc: linux-fscrypt@vger.kernel.org, linux-ext4@vger.kernel.org,
 linux-mtd@lists.infradead.org, stable@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Mon, Dec 28, 2020 at 10:54:29AM -0800, Eric Biggers wrote:
> Backport four commits from v5.11-rc1.  I resolved a conflict in the
> first one.  The rest are clean cherry-picks which didn't get picked up
> yet because they depend on the first one.
> 
> Eric Biggers (4):
>   fscrypt: add fscrypt_is_nokey_name()
>   ext4: prevent creating duplicate encrypted filenames
>   f2fs: prevent creating duplicate encrypted filenames
>   ubifs: prevent creating duplicate encrypted filenames
> 

All now applied, thanks.

greg k-h


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
