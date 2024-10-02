Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1DAFCF31A1
	for <linux-f2fs-devel@archiver.kernel.org>; Wed,  2 Oct 2024 08:49:24 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1svv2w-0003WT-Ta;
	Wed, 02 Oct 2024 08:49:22 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <ryan.roberts@arm.com>) id 1svv2v-0003WD-9T
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 02 Oct 2024 08:49:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:Subject:Cc:
 To:From:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=kmXiAMOd14tS973nWG1/axwit4ujiH5ophZ8QRO+ngA=; b=d+9qc7gGAUgpk4dwnG1Ed3xCnb
 6ilzzVmLsH+ocy9PPQZ7/r4BZ24M3HlYJ0nTcmOjxnALBvw6Q9y5bW8D90yCCmqJ35A4h/JyJADEv
 SAY5YVBsRIUAZRbVs8wyleDRKdBZJs7noxMn5C+zKICaBlHCK+L+Vdk/aSCH7H/+o3x0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:Subject:Cc:To:From:MIME-Version:
 Date:Message-ID:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=kmXiAMOd14tS973nWG1/axwit4ujiH5ophZ8QRO+ngA=; b=a
 3MTALk9zOYv7nZSpmPlYsymT0jfPnu9xhZ2XZcDYkOxp3UDS2zTwxIC6kEqzd04y2R9jq72DnxESw
 UHuJqVn0zcz9fFO1etPUW15JjAKof653TsU8qKTE7A4Wez3e3+4lHJgAMRYbxGb+EPRu/wxrI4WWE
 0wWyDHOtCEfQ8VcM=;
Received: from foss.arm.com ([217.140.110.172])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtp (Exim 4.95)
 id 1svv2u-0002Xl-7Z for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 02 Oct 2024 08:49:21 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 68A46339;
 Wed,  2 Oct 2024 01:32:55 -0700 (PDT)
Received: from [10.57.85.161] (unknown [10.57.85.161])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2FDAD3F64C;
 Wed,  2 Oct 2024 01:32:25 -0700 (PDT)
Message-ID: <671e8774-acaf-4c59-b06a-bf1511de022a@arm.com>
Date: Wed, 2 Oct 2024 09:32:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-GB
From: Ryan Roberts <ryan.roberts@arm.com>
To: Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>
X-Headers-End: 1svv2u-0002Xl-7Z
Subject: [f2fs-dev] Plans for F2FS Supporting Large Folios
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
Cc: Ian Rickards <ian.rickards@arm.com>, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hi Jaegeuk Kim, Chao Yu,

I heard (via Matthew Wilcox) that you may be in the process of forming plans to
add large folio support to f2fs? If so, I wonder if you could let me know how
those plans are progressing? I saw your v6.12-rc1 pull request did a lot of
conversion from struct page to struct folio (of the small variety for now) but
wondered if this is intended as pre-work for enabling large folios?

I've been doing a lot of work on the anonymous memory side to support large
folios ("mTHP") and hook that up to arm64's contpte pgtable support. This
improves performance nicely.

Additionally I have experimented (on XFS) with ensuring that text mappings are
contpte mapped where possible and this reduces pressure in the iTLB to improve
performance further. But it all relies on the file system supporting large
folios. I'd very much like to realize these performance gains on Android, but
that requires the file systems that Android uses to support large folios.

It would be great to understand your plans, if any, and figure out if/where Arm
may be able to help accelerate activities in this area. I'm not (yet!) an fs
expert, but I see that f2fs is already using iomap, so perhaps now that you are
supporting small folios, switching up to large folios is not too big of a step?

Thanks,
Ryan


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
