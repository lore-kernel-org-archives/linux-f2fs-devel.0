Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B60AC19F2D
	for <linux-f2fs-devel@archiver.kernel.org>; Fri,  5 Aug 2022 01:06:13 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.94.2)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1oJlmz-0005Pi-JL; Fri, 05 Aug 2022 01:06:09 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <chao@kernel.org>) id 1oJlmx-0005Pc-NJ
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 05 Aug 2022 01:06:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=B7XxrfERBbTlIBqrM1waNRn5SpO/7um6JtmhY9AoCtQ=; b=IVE1+IWZLYngnJxho6LKS1OH3i
 lhcCs7AlkTLfioWMwHpCvnZ9lLj2U34SbY8+w6K62kL76+aSY14gD71RQc511V7Y31Q0Pf520w6tA
 QB45ogi1WDSY5napCdibdWEnzHmO/RkyOz9lzy1jXXdrOHUIAqtdkk9w1tatFDyhAVtY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=B7XxrfERBbTlIBqrM1waNRn5SpO/7um6JtmhY9AoCtQ=; b=Jw/y2FLlvCbzjtUDamCCEvi/J9
 WOBuRj6MmCEy00/8UXtqLEON+VbNCVTzz/GO9+50G3JnFPNUE4sZSA3Gkpe5CB79dc8n3FISpDSM6
 sIAnjhfF8r4HY/lSaSYoNjQ5lJqdU4Mt0G7oDgzeHeKxNpxfUwqdTIQvQwJapJT7uR4s=;
Received: from ams.source.kernel.org ([145.40.68.75])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.94.2)
 id 1oJlmw-003sDi-Hv
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 05 Aug 2022 01:06:07 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 4B3D2B827A9
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri,  5 Aug 2022 01:05:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0E64C433D6;
 Fri,  5 Aug 2022 01:05:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1659661551;
 bh=B7XxrfERBbTlIBqrM1waNRn5SpO/7um6JtmhY9AoCtQ=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=b1yFBpTR5VdyzsR21hKFUTdBpG2mnd9APc2Ws35mS0ZEFVPm+IA1RNfE6avnAf3PQ
 zqU1hl0Gq50c5hgBr6rDyM0tBMDpFbaYz7wHjW1dPPsJABxn9r7L8F2C5D48HKBRxb
 NYXxM+B1Mjhe2EHJ6ZW9tLUkjoornqA1nh1HLo/G5ckv9eUx9Ar0U7l8h2LJFnENRp
 KLOTHeXmGd9OcYOz4/fy9xfObl0EMzbCW1enu5w0GfYZ4czzBQ5CZh/vzIMs6GCLSb
 wmpxnya0hsV0hBcg0cfTsYjAkCmrjrd4kKCbUJjsJmlDjR9Bq9HI55PhcIXqvLLP2U
 ViP7RwB6vkvEQ==
Message-ID: <88992c8e-3a39-bfd2-4850-03d46ff6585a@kernel.org>
Date: Fri, 5 Aug 2022 09:05:46 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Content-Language: en-US
To: Eric Biggers <ebiggers@kernel.org>
References: <20220804134140.14455-1-chao@kernel.org>
 <YuwP67c0oNjhojmt@gmail.com>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <YuwP67c0oNjhojmt@gmail.com>
X-Headers-End: 1oJlmw-003sDi-Hv
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix to check compression feature
 before enabling file compression
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
Cc: jaegeuk@kernel.org, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2022/8/5 2:28, Eric Biggers wrote:
> How is this different from the same check that occurs earlier in the function?

Oops, I missed that one, please ignore this patch.

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
