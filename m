Return-Path: <SRS0=P1UQ=MJ=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E92F4C636C9
	for <linux-f2fs-devel@archiver.kernel.org>; Sat, 17 Jul 2021 07:45:50 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 97842611F1;
	Sat, 17 Jul 2021 07:45:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97842611F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1m4f1A-0006jG-DT; Sat, 17 Jul 2021 07:45:48 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <chao@kernel.org>) id 1m4f19-0006j6-5w
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 17 Jul 2021 07:45:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=J9biFivKYxN4TnjBze2GrW7lT/miEtB1oBEkM3n9SH0=; b=i4G/DTV9/t3NZzjQJjfftSoEuy
 iIhvpzyl+qFVmQOBaMCqFkv+qTOCvNsDcgRThLL8e7fNwTpxltjDi5HJmfZs6JQj10Yo2AmhoeLY0
 oOuO+C9w83oT5pKQVb3QRHrBP5PQbF2wRXpqhk4CdS6z7Jb2tLOxDM+OUZENxHtz27lM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:
 Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=J9biFivKYxN4TnjBze2GrW7lT/miEtB1oBEkM3n9SH0=; b=Z876XzczzI8VXPraGcqpoioU4g
 M2es2g66jXD3P8du7z/BEMfeIY866dMAMCQiLVSMABp/uYtt5+QW3E3WvD+3tXpqkicBPF70rCm3y
 D9N2iiEFEQsPhX9cueyWyQDrYnRo2pIN2T3CrBxEO/v6+WwhUSEy/bZGrDmn4lXSG4ag=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.3)
 id 1m4f11-00BOTD-Bn
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 17 Jul 2021 07:45:47 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0B430611F1;
 Sat, 17 Jul 2021 07:45:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1626507928;
 bh=OEtAsKx5RNNjXa5rjXAgFB+PHCB5X6hhQSXwo4OcDaw=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=A4oAGQZtbDBWTJjoPtvjDIFMtCQsPdF4NaxYpOtiPSYoIlxWTLMmPE9CeYOveQuS3
 UlTcsT7d/LcXUaVoReMgSEBGOKc0AX0t+YbToiRB1xfLpSFz8uQPOiW2Nj3BiAFGdp
 pYgKafCYHUIrsBiQtMS5YgDsXioBi8NkdRvwNJXTLB9yE837sFUNoVOOcJVIAFEj8X
 1E7lVRNHgfTIqDG5o0ww13KBQAPGMvpRC22ngULgaJJ40J5pFMssxCBHbhiUTPJwGa
 WTVLTESKV2ivVizxLnAXMzIwJoFGn71wUvB/yeN0NvkGWkw9vn6QlJTtkgomDWMjkC
 LQdoaz5roKyww==
To: Jia Yang <jiayang5@huawei.com>, linux-f2fs-devel@lists.sourceforge.net
References: <20210714074606.3858442-1-jiayang5@huawei.com>
From: Chao Yu <chao@kernel.org>
Message-ID: <5876780a-0be4-1037-88e5-7bdc8ee29f7a@kernel.org>
Date: Sat, 17 Jul 2021 15:45:25 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210714074606.3858442-1-jiayang5@huawei.com>
Content-Language: en-US
X-Headers-End: 1m4f11-00BOTD-Bn
Subject: Re: [f2fs-dev] [PATCH -next] f2fs: Revert "f2fs: Fix indefinite
 loop in f2fs_gc() v1"
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
Cc: jaegeuk@kernel.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

+Cc Sahitya Tummala <stummala@codeaurora.org>

On 2021/7/14 15:46, Jia Yang wrote:
> This reverts commit 957fa47823dfe449c5a15a944e4e7a299a6601db.
> 
> The patch "f2fs: Fix indefinite loop in f2fs_gc()" v1 and v4 are all
> merged. Patch v4 is test info for patch v1. Patch v1 doesn't work and
> may cause that sbi->cur_victim_sec can't be resetted to NULL_SEGNO,
> which makes SSR unable to get segment of sbi->cur_victim_sec.
> So it should be reverted.
> 
> The mails record:
> [1] https://lore.kernel.org/linux-f2fs-devel/7288dcd4-b168-7656-d1af-7e2cafa4f720@huawei.com/T/
> [2] https://lore.kernel.org/linux-f2fs-devel/20190809153653.GD93481@jaegeuk-macbookpro.roam.corp.google.com/T/
> 
> Signed-off-by: Jia Yang <jiayang5@huawei.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
