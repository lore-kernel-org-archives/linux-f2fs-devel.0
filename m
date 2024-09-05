Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3B6FCD4F4C
	for <linux-f2fs-devel@archiver.kernel.org>; Thu,  5 Sep 2024 01:15:17 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1sm15g-0006sV-A3;
	Thu, 05 Sep 2024 01:15:17 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1sm15e-0006sO-LF
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 05 Sep 2024 01:15:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=KqT2ttCxSZ4ixOt77pqvNsyPhKRH6paegj0OQnyVCLc=; b=IYwVR1iZWGtFUfznHD3Mti5YyB
 R8kloDaj9bQsnEPsnHnC4uMBAlX3S/2ljtC4RSd6Kf6Si9QDXpWnOdYdW7Ruqff+joc7x36YFMWBZ
 Q/dc/noaJbcET4c0GyGiPEcOxmnYY7ULDshJ9aFuqLJLpUU4uVFScxvjyQNFNR0mZoeE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=KqT2ttCxSZ4ixOt77pqvNsyPhKRH6paegj0OQnyVCLc=; b=DZO9IxRsns1+ZlgyWPsbK7SfQz
 QsnSAtCtTfLBfpM038VW4Crc5SvAZ0fvNww3E+//ZRZoqVyE1RP3MMiBj6yEWtAbfpxRA9xOJ46LD
 kXNYJIrqQiDZou09JWfTH5JF69fKQ+OE/C58e6830FgBYyvBFuPtoNFc1cXrn3dVGaCI=;
Received: from nyc.source.kernel.org ([147.75.193.91])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1sm15e-00066u-Mt for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 05 Sep 2024 01:15:15 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id BBAA8A40A1E;
 Thu,  5 Sep 2024 01:14:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86156C4CEC8;
 Thu,  5 Sep 2024 01:15:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1725498903;
 bh=3fWJeDzfvSnisSK5HoEs4qKH4+GRMvygpcT7XlA/xvo=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=h5SKK1ae0STWk1Orez3ypAbXneFv0yqmIvUux0O2WwHcbKoo4FK5+/TMORIxxmg+u
 +iwdlIkECnL4dDlmijBSor/XWbxmG6VgMVpZLZRniUiH9FnZx6dxAKut3wWIrdrt1n
 7Kl63t5viX5JO45I3XsbFrk0GofOoWOEqLBDYyW43V0XBKgScrNAPJ3keUAGGffMI3
 yjQSoMlp5AdEVKUqK8PiIj7zAmTHNizJMkgIS/MsAS0poju7jv0ytT0nRBdgVbH3U1
 FWRTOZMWuupizkurgJVUYnE6wWqNUSOB7o4LZpu53eIdC6titZJgjZxHIYDc+x6yFa
 wxOqaGxW9rPog==
Message-ID: <f31dec2f-01c4-40e5-bc0d-06eb921392b8@kernel.org>
Date: Thu, 5 Sep 2024 09:14:59 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Daeho Jeong <daeho43@gmail.com>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
References: <20240903173157.602995-1-daeho43@gmail.com>
Content-Language: en-US
In-Reply-To: <20240903173157.602995-1-daeho43@gmail.com>
X-Headers-End: 1sm15e-00066u-Mt
Subject: Re: [f2fs-dev] [PATCH] mkfs.f2fs: use correct endian conversion for
 writing lpf inode
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2024/9/4 1:31, Daeho Jeong wrote:
> From: Daeho Jeong <daehojeong@google.com>
> 
> The conversion between cpu and little endian is incorrect.
> 
> Signed-off-by: Daeho Jeong <daehojeong@google.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
