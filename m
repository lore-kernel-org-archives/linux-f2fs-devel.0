Return-Path: <SRS0=Ksgo=FM=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF1FDC4361B
	for <linux-f2fs-devel@archiver.kernel.org>; Tue,  8 Dec 2020 03:49:48 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4EC24239EB;
	Tue,  8 Dec 2020 03:49:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4EC24239EB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1kmU0Z-0003Ve-NJ; Tue, 08 Dec 2020 03:49:47 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <ebiggers@kernel.org>) id 1kmU0X-0003VM-Rc
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 08 Dec 2020 03:49:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Fu5y+4SdNUY6fES5c4juJXRA/a2B6b9V0whODR+68tI=; b=Z+eNPj9JgTf+p4KrKkXJqJU8el
 0xUm1UkMiIUrD/fqWUzvtQNi5439L4DOUqJzvocon+rG4Z1oiGu81yg4ihhN1irJJFc3evjrkjPCv
 Z8+kwOytB4u7fpRLUg0k0DQbAMJFjHUztRc8gJ1Ue1K4C8m2+lyLIZLZFxljkBPL9m5c=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=Fu5y+4SdNUY6fES5c4juJXRA/a2B6b9V0whODR+68tI=; b=mr1jWOV75K3sQxxoiRStg/6TWq
 RF+fyq32NzJmrMxSYZ8fJp/99I0pIDvIBKb16cIZBJ+zyzmA1elSq5Hx/nDRPYnn3Kmuu+z0FB1kA
 KpISYX68+dwTAaot9D8QvTfjhv3cBnJ3GAoobz9FqZkoypeuZi4gMf+hJTeS5EP4mr68=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1kmU0R-002vmR-0S
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 08 Dec 2020 03:49:45 +0000
Date: Mon, 7 Dec 2020 19:49:15 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1607399373;
 bh=K+AuuBZl4hBPvkhnz+5DsdlBPwu1F5l2MO6LkZGaZhg=;
 h=From:To:Cc:Subject:References:In-Reply-To:From;
 b=m43jbMlV5Adfj+4GDftjqlqK9gsflMPNoZNr0MNhv8r7E2laJOnOhRlrbHijhOOYa
 JgTL1IJS4RlKO85/Dm6SoqZq8DakS5MNbROKyuu3D+VcoQM97Q3QB/nXM7onSTSelY
 TZKG9cYrbJIKaqsJ0hU4hp1/bC9LabTo0EnTv+4DFm/JAVYS1CMJerRQW2cb4q1uka
 cNwakO6vJoc4vFMyQYRqWZslvNfHROcig2VARRAQhn9vuie077K7YdbdP4/0W2ZGpr
 6DM9Pt+4KSrM0xVhyO+qePsDeF78nMBdex5a+qkWEv9yvWolb7hZ8gfqot9aB9Jspy
 EKgQA9IUPI3+Q==
From: Eric Biggers <ebiggers@kernel.org>
To: Daeho Jeong <daeho43@gmail.com>
Message-ID: <X873u1lHmTwktniU@gmail.com>
References: <20201203065615.402494-1-daeho43@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201203065615.402494-1-daeho43@gmail.com>
X-Headers-End: 1kmU0R-002vmR-0S
Subject: Re: [f2fs-dev] [PATCH v3] f2fs: add F2FS_IOC_DECOMPRESS_FILE and
 F2FS_IOC_COMPRESS_FILE
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
Cc: Daeho Jeong <daehojeong@google.com>, kernel-team@android.com,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Thu, Dec 03, 2020 at 03:56:15PM +0900, Daeho Jeong wrote:
> From: Daeho Jeong <daehojeong@google.com>
> 
> Added two ioctl to decompress/compress explicitly the compression
> enabled file in "compress_mode=user" mount option.
> 
> Using these two ioctls, the users can make a control of compression
> and decompression of their files.
> 
> Signed-off-by: Daeho Jeong <daehojeong@google.com>
> ---

I still don't understand the purpose of these new ioctls.  What's wrong with
just FS_IOC_SETFLAGS(FS_COMPRESS_FL) to compress a file, or FS_IOC_SETFLAGS(0)
to decompress a file?  That appears to already be supported...

- Eric


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
