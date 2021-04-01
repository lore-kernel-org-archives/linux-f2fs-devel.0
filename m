Return-Path: <SRS0=Cd0Z=I6=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A378BC433ED
	for <linux-f2fs-devel@archiver.kernel.org>; Thu,  1 Apr 2021 03:25:17 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A80561057;
	Thu,  1 Apr 2021 03:25:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A80561057
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1lRnxM-0004bo-2f; Thu, 01 Apr 2021 03:25:16 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <jaegeuk@kernel.org>) id 1lRnxK-0004bb-Vt
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 01 Apr 2021 03:25:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Ac1qPiliqfGaZYr8NWvGLzmKj3TZPhLczh+fiBY1WY4=; b=UB4yRKnUCw/GQ/IbBwpuKV5Gv8
 dwS+QwUvnHwbD/br7liG+vDUAnQ4sidcl+G+A95CiVaSzjcoykdiRwNeEg8lqFOKm6gW/35v0Aby4
 nAhHi7SEcl91STyKngN2G8xT23vRkslBt1YWSqHmGqTNflx1Az0AGJEGdJIstEOxmoDg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=Ac1qPiliqfGaZYr8NWvGLzmKj3TZPhLczh+fiBY1WY4=; b=KqBc32M7FvYB7O7Q+Kh/YqpqeN
 Fh2Iqk2LYwJZJt/Xw3ouj9YlO2vp7IUsmy0oD1heLO1UqMiv8kUQKFTWKpyp9vwF3IyYhe9inFCvg
 rkCaEHip648FbCegg9K4uOlPVrvZ+ygRkq7itB4tOft7FyMXQyPMoFWTeltQR7W3t5Ns=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.3)
 id 1lRnxC-0006xH-1n
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 01 Apr 2021 03:25:14 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id E799261057;
 Thu,  1 Apr 2021 03:24:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1617247494;
 bh=xkINDlKrN5U3bauiFW8YXkJA/tMbxli4vUgJ3TKr54Q=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=RhbnHQL2XkwTldN/Lu3AfXeElp84DGBKrSQGOSBWWl1+h2oTCp/Su63nOBjp9NkD/
 oS/qDdXd+H3G3XFvJuFt+wjZDcKTIlhdSm6xUti65PTk8DU2mlP1cX4JMD83y5qE9E
 WRhXQF92PiLVXCuDszDeSNenfrB4YVAwT0Y/rz5euw2zbhiFeniFsqqnMdZNgz5qJX
 hVnIebGXbn9ZR5kXeFqDBm1Rwkp2tl9GXBYvHLPFkcnAdBb/o/r0L9aLM19mgAYBXs
 uUdmTd8A5kTKqVz2zAN5mQoyAOX8TAwWFbcRENQi8x/gw+TjO02zpG9gxTBajhXjVN
 hvVTwIA2LUlPg==
Date: Wed, 31 Mar 2021 20:24:52 -0700
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: beroal <me@beroal.in.ua>
Message-ID: <YGU9BGiHQl908xTd@google.com>
References: <739ae455-07b4-7dc4-1789-5b162ed25ede@beroal.in.ua>
 <bc3759b9-c606-5e77-40f0-c590bbc53bfb@beroal.in.ua>
 <YGPTWqUtHqEyRLMv@google.com>
 <10ac38ce-4e76-4e12-2112-bd4cc10d1ab4@beroal.in.ua>
 <YGSZw6Azb8E43gOl@google.com>
 <6c50097b-4666-6218-1c87-b4a494a239d4@beroal.in.ua>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <6c50097b-4666-6218-1c87-b4a494a239d4@beroal.in.ua>
X-Headers-End: 1lRnxC-0006xH-1n
Subject: Re: [f2fs-dev] `mount` reports an error, but `fsck.f2fs` does not
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
Cc: linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 04/01, beroal wrote:
> On 31.03.21 18:48, Jaegeuk Kim wrote:
> > On 03/31, beroal wrote:
> > > On 31.03.21 04:41, Jaegeuk Kim wrote:
> > > > Hi,
> > > > 
> > > > On 03/27, beroal wrote:
> > > > > Ping.
> > > > > 
> > > > > On 20.03.21 00:46, beroal wrote:
> > > > > > Hi. After I extended a partition containing F2FS with a recent version
> > > > > > of Gparted, the partition no longer mounts. `mount` reports an error,
> > > > > > but `fsck.f2fs` does not see any problem (well, except for `Invalid CP
> > > > > > CRC offset: 0`) and does not fix the file system.
> > > > > > 
> > > > > > ```
> > > > > > losetup /dev/loop0 arch-os.img
> > > > > > mount -t f2fs -o ro /dev/loop0 /root/mnt/temp
> > > > > > ```
> > > > > > 
> > > > > > ```
> > > > > > [ 6890.647749] F2FS-fs (loop0): Wrong valid_user_blocks: 16040048,
> > > > > > user_block_count: 10016768
> > > > > > [ 6890.647808] F2FS-fs (loop0): Failed to get valid F2FS checkpoint
> > > > > > ```
> > > > > > 
> > > > > > ```
> > > > > > losetup -d /dev/loop0
> > > > > > fsck.f2fs arch-os.img
> > > > May I ask run this?
> > > > 
> > > > # fsck.f2fs -d 3 arch-os.img?
> > > The result is a log of size 270 MB. I'll send it privately to
> > > jaegeuk@kernel.org if you don't mind. It contains directory and file names.
> > Thanks.
> > 
> > segment_count_main                      [0x    9a95 : 39573]
> > -> 39573 * 2MB = 78GB as user space
> > 
> > overprov_segment_count                  [0x    4e29 : 20009]
> > -> 20009 * 2MB = 40GB as overprovisioned space which user can't see.
> > 
> > But,
> > 
> > [FSCK] valid_block_count matching with CP             [Ok..] [0xf4c070]
> > -> 0xf4c070 = 16040048
> > 
> > valid_block_count                       [0x  f4c070 : 16040048]
> > -> So, this is correct.
> > 
> > So, I suspect overprovisioned space is wrong and guess resize.f2fs assigned
> > a wrong value. May I ask from and to which capacities you resized? I may
> > need to reproduce it quickly.
> Resizing was done by Gparted. I don't remember precisely, but the previous
> partition size was around 65536 MiB, and the F2FS used the whole partition.
> The new size most likely was the current size of the partition, 79549 MiB.

Ah, you didn't call resize.f2fs, but just changed the partition size?


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
