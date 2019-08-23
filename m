Return-Path: <SRS0=HDuJ=WT=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08591C3A5A2
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 23 Aug 2019 13:09:45 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C923A21848;
	Fri, 23 Aug 2019 13:09:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="Fgl7c35M";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="RVLm4X/Y";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="T4bRJWvN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C923A21848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1i19K4-0004QY-1G; Fri, 23 Aug 2019 13:09:44 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <chao@kernel.org>) id 1i19K2-0004QN-95
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 23 Aug 2019 13:09:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 MIME-Version:Date:Message-ID:From:Cc:References:To:Subject:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=uTsBC79HFMWB0GutKcVH+GKMgPAnSDZSXt4H4Z1cZgU=; b=Fgl7c35M+Y0LIV70pAO6rMyt6j
 uZE63+sy/UliOc/NWFvcHrWKd57by3Z8VzfFibE16bVrkhvMzSEiM+oYH0EfKYb2pjOVFdvTKP7GI
 MPjX8TLfEw4bRR5F+Zgd0H+w+UZMuQqNA2fhUTRStaXj9qEkOXj0HSY5tRdHxEsynNfw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:
 Message-ID:From:Cc:References:To:Subject:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=uTsBC79HFMWB0GutKcVH+GKMgPAnSDZSXt4H4Z1cZgU=; b=RVLm4X/YH1YS2am3iBtzUUDpxm
 cOpd2IGmKwPkqoleOcg4wBJe4kFoR3pcs4HhdnsaRYblEOPn6pVeJm7FwYvNg2nS/9nuyjUUGlpJq
 ALJaCKS0scZplw4xvlh+01OfohlBkETccVqOBc22lU6CfkVsWSnhTVdqHQAhJmqnDZbk=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1i19Jx-00HQTg-Ma
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 23 Aug 2019 13:09:42 +0000
Received: from [192.168.0.101] (unknown [180.111.132.43])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 4F02F21848;
 Fri, 23 Aug 2019 13:09:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1566565772;
 bh=12Ge5j75b9s5rRNxijeffCOODw8p97MJxgB+uU+409A=;
 h=Subject:To:References:Cc:From:Date:In-Reply-To:From;
 b=T4bRJWvNjhpQSyHiwkiAahWqVE/dplxO1oFtLfCDssFX5WtAd6tTb7uRrMjoFVtKD
 joMy4hroIIshvo0sQIuwFcYcY+dxFb4yUyNnGfD1l1e1JvSG3Kv5XbnMYUODGg3ji/
 MANbwhSPMXOTuojpSmI/b7SIsEcpTiEye23UvY5g=
To: Damien Le Moal <Damien.LeMoal@wdc.com>
References: <20190821044802.29702-1-shinichiro.kawasaki@wdc.com>
From: Chao Yu <chao@kernel.org>
Message-ID: <51daaa42-58b0-85dd-dcda-13185afe5b63@kernel.org>
Date: Fri, 23 Aug 2019 21:09:19 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190821044802.29702-1-shinichiro.kawasaki@wdc.com>
Content-Language: en-US
X-Headers-End: 1i19Jx-00HQTg-Ma
Subject: Re: [f2fs-dev] [PATCH v2 0/4] fsck: Check write pointers of zoned
 block devices
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
Cc: Jaegeuk Kim <jaegeuk@kernel.org>, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hi Damien,

Do you have time to take a look at this patch set, and add a reviewed-by if it
is okay to you. :)

Thanks,

On 2019-8-21 12:47, Shin'ichiro Kawasaki wrote:
> On sudden f2fs shutdown, zoned block device status and f2fs meta data can be
> inconsistent. When f2fs shutdown happens during write operations, write pointers
> on the device go forward but the f2fs meta data does not reflect write pointer
> progress. This inconsistency will eventually cause "Unaligned write command"
> error when restarting write operation after the next mount. This error can be
> observed with xfstests test case generic/388, which enforces sudden shutdown
> during write operation and checks the file system recovery. Once the error
> happens because of the inconsistency, the file system requires fix. However,
> fsck.f2fs does not have a feature to check and fix it.
> 
> This patch series adds a new feature to fsck.f2fs to check and fix the
> inconsistency. First and second patches add two functions which helps fsck to
> call report zone and reset zone commands to zoned block devices. Third patch
> checks write pointers of zones that current segments recorded in meta data point
> to. This covers the failure symptom observed with xfstests. The last patch
> checks write pointers of zones that current segments do not point to, which
> covers a potential failure scenario.
> 
> This patch series depends on other patches for zoned block devices, then it
> conflicts with the master branch in f2fs-tools.git as of Aug/19/2019. It can be
> applied without conflict to dev and dev-test branch tips.
> 
> Changes from v1:
> * Fixed build failure on dev branch
> 
> Shin'ichiro Kawasaki (4):
>   libf2fs_zoned: Introduce f2fs_report_zones() helper function
>   libf2fs_zoned: Introduce f2fs_reset_zone() function
>   fsck.f2fs: Check write pointer consistency with current segments
>   fsck.f2fs: Check write pointer consistency with valid blocks count
> 
>  fsck/fsck.c         | 161 ++++++++++++++++++++++++++++++++++++++++++++
>  fsck/fsck.h         |   3 +
>  fsck/main.c         |   2 +
>  include/f2fs_fs.h   |   3 +
>  lib/libf2fs_zoned.c |  81 ++++++++++++++++++++++
>  5 files changed, 250 insertions(+)
> 


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
