Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68C60C433F5
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 15 Apr 2022 09:33:23 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.94.2)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1nfIKR-0001ZU-7p; Fri, 15 Apr 2022 09:33:22 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <chao@kernel.org>) id 1nfIKP-0001ZE-O1
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 15 Apr 2022 09:33:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=XJURSTUZRwBsXFQhVCynVRa72BTKKVseMmHYjgtqAL4=; b=J0JaNOFJcqGeORfzRozAOv0IVK
 42sANslQOFuwZRQxP2yDTJrUNt8bQDbAyfSfxFeRCJ32E63ScjaThgQtk54oL1+0AC+k52LJ43mVP
 RwnHq1knes74zfBFKYSL96oNX2vkn4UG03IH9njKBqebaU1BCKsxZ3rrJTiwI7V9Xrkg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=XJURSTUZRwBsXFQhVCynVRa72BTKKVseMmHYjgtqAL4=; b=HDkeZFHWcZAPEj8YnNvS6dtFRO
 maaHqKrFv48QqFrjbLRiGs27Wc6/IENlwK7HmvJCQ07wa7h2pos89cmPS2Z+/WsYdd1A8wsygGOqV
 7ovy8ZjAXj9SkCxMeNlQneQVZh5XiGnYIW8/DeouCimQTqKTsrGfM++EgomIGSMkf2po=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.94.2)
 id 1nfIKM-0005Up-Kq
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 15 Apr 2022 09:33:20 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 219A6621C0;
 Fri, 15 Apr 2022 09:33:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C3AAC385A6;
 Fri, 15 Apr 2022 09:33:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1650015192;
 bh=6u7TYuQ7weOypGJkP6bl3bYHJlq3pb9zPmXx8u5MZTQ=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=jYth1qlSNELLiQ77SD55B61KQA8qKZNCGH4eeI610PF658j6Bbd27mAzpAAdpzcoP
 ym1Oqz9AQYtiuJk1XZx7Bb9rEVx4HftG1A39SbZAcW6f6cH6Zan8ikJRM5zEgjRkdv
 45M94vVrYxleIukwB3Vrmg+8JbtO2aP6wlCSe0+pplPBLygVv17wdCCkFvyWSSzr1e
 HbJArlReu/eM39FFo7jriwNKkjCtK5DZcY8FegDphBVsxlYjxSJTQyhOS/5c8i1riU
 oaEhn+gRbWWQmVTBw3Mv1o4EZkM8fGIrSYFIBeN3S16ln29g2bCmiZlEDuEcDIPSKM
 wyGmwPBnnWylQ==
Message-ID: <dc6e857f-68bd-2028-35cb-ebb34d5facba@kernel.org>
Date: Fri, 15 Apr 2022 17:33:08 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Content-Language: en-US
To: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>, jaegeuk@kernel.org
References: <20220415084931.49880-1-jiapeng.chong@linux.alibaba.com>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20220415084931.49880-1-jiapeng.chong@linux.alibaba.com>
X-Headers-End: 1nfIKM-0005Up-Kq
Subject: Re: [f2fs-dev] [PATCH] f2fs: Fix signedness bugs in
 f2fs_gc_pinned_control functions
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
Cc: Abaci Robot <abaci@linux.alibaba.com>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2022/4/15 16:49, Jiapeng Chong wrote:
> Fix the following smatch warning:
> 
> fs/f2fs/gc.c:688 f2fs_gc_pinned_control() warn: signedness bug returning
> '(-16)'.

Oops, thanks for catching this...

It's better to merge this patch into original patch, if you don't mind?

Thanks,



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
