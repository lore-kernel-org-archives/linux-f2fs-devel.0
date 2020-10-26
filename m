Return-Path: <SRS0=JrMS=EB=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A077DC4363A
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 26 Oct 2020 23:06:25 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F1D720708;
	Mon, 26 Oct 2020 23:06:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="NwduMIts";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="Jkj6UbVX";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="aLNQE8/F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F1D720708
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1kXBZI-0007MN-1q; Mon, 26 Oct 2020 23:06:24 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <ebiggers@kernel.org>) id 1kXBZG-0007ME-B3
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 26 Oct 2020 23:06:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=U88gpj0RjfWZ+7UwQd8GENwEVkP3wpl6UeK7NjmYAtQ=; b=NwduMItsCIcG06dO5Jm4HP4Nc2
 +LGvQULzlOLsnoIQtXMwSCIb9yutUxJztmIy59ElvFUF4kOYRVGUR4MrIv4juhVFIW3um+hAOoX1P
 KvKBzp6s+wTNE5jNxal+4rgGa2tzAPHXL0T6htGTY2rhXN8u0uOu1mYNxvHpKpPrvlqQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=U88gpj0RjfWZ+7UwQd8GENwEVkP3wpl6UeK7NjmYAtQ=; b=Jkj6UbVXIRpHf/4+95WlszGeMz
 UI0smAjeb//5dNhrO0vdyP2+b2rm/mOMdcrWeN4bH4J0KLgwYOBVeS2vXHD86APIYiY4zwMgZLX1/
 zAJXjzjIHxEqJd6k5jhTTwhDuMIPBwGZvz6YwCl+MSHfbgOEN+s04rds7L9RvDpwJmzc=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1kXBZ8-00ErsE-Nd
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 26 Oct 2020 23:06:22 +0000
Received: from gmail.com (unknown [104.132.1.76])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 0D50220708;
 Mon, 26 Oct 2020 23:05:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1603753557;
 bh=buPKfI0LODfxV6G8Mb2QH2W7D0RNdKWV1mnYWK+ZD4w=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=aLNQE8/FKDRMdQzhaiUWlC52n2l8ThNOlkegMMRY42bQUEvvJ0hTKCP08XYrNdylM
 0ftsXqtUj0lAvQpmVR+57fCNCeEsgEP7CqOb/PilPdVGmJNSSnz6irn+ca8Z9cEVDk
 S5SpcdaF0dOtnh0u5xXdRV2b3W1yC6eznWIoxRyg=
Date: Mon, 26 Oct 2020 16:05:55 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Daeho Jeong <daeho43@gmail.com>
Message-ID: <20201026230555.GB1947033@gmail.com>
References: <20201026041656.2785980-1-daeho43@gmail.com>
 <20201026190406.GL858@sol.localdomain>
 <CACOAw_xFijZOokM4R1XYKoFvRthk-ZfC+hNz0c-HqQuurjp87g@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CACOAw_xFijZOokM4R1XYKoFvRthk-ZfC+hNz0c-HqQuurjp87g@mail.gmail.com>
X-Headers-End: 1kXBZ8-00ErsE-Nd
Subject: Re: [f2fs-dev] [PATCH v3 1/2] f2fs: add
 F2FS_IOC_GET_COMPRESS_OPTION ioctl
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

On Tue, Oct 27, 2020 at 08:02:18AM +0900, Daeho Jeong wrote:
> I thought I gave the information about that in the commit message. Is
> this not enough for you?
> Actually, there is no space for F2FS ioctl documentation now. :(
> 

The commit message doesn't really matter.  What I am asking for are actual
documentation and tests.

The fscrypt ioctls, for example, are all documented in
Documentation/filesystems/fscrypt.rst, and they have tests in xfstests.

- Eric


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
