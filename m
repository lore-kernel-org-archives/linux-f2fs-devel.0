Return-Path: <SRS0=9+GF=EJ=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 144BAC2D0A3
	for <linux-f2fs-devel@archiver.kernel.org>; Tue,  3 Nov 2020 09:02:06 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 83C0320756
	for <linux-f2fs-devel@archiver.kernel.org>; Tue,  3 Nov 2020 09:02:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="Rs1C+yC2";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="mh2P8xCJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83C0320756
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1kZsCU-00072h-4u; Tue, 03 Nov 2020 09:01:58 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <yuchao0@huawei.com>) id 1kZsCS-00072W-QL
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 03 Nov 2020 09:01:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 MIME-Version:Date:Message-ID:From:References:CC:To:Subject:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=o12VY5wEqyIvKiVy7gQYf6mEI936BrgLpo94W8Ng4DI=; b=Rs1C+yC2ucu8wPbagYpAsMEV2B
 mJ3+HlQOrz3zgzdPA4TerbQ/OkYRrDAX6qaYpWNlgb/pBw+FVJ9Y0XSnBS/VeQc+83BtWT61di7M9
 RSYIrWTUqe/37+AUWX2cfBTqvDVhp7tTGrjs5UndUfRD+eVqFIniAYpGooC5bVZYprIc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:
 Message-ID:From:References:CC:To:Subject:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=o12VY5wEqyIvKiVy7gQYf6mEI936BrgLpo94W8Ng4DI=; b=mh2P8xCJDx6Dy9X1oOt3+lObBf
 2RKNNhW9LFj9MV+/PoZmcbxTUKYfq5FgSllMGD/T70m2kbE8vDwwW7WOSjpT2T/wxeqrw4Xc1o6Ss
 I15ouPlMcMf6MLwkPMIBOlk6r8LdOXyGilnpiZ4f2q+5t6FzP+OKXdd5SWLF2PhpQqTM=;
Received: from szxga04-in.huawei.com ([45.249.212.190])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1kZsCM-007VWF-DI
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 03 Nov 2020 09:01:56 +0000
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.60])
 by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4CQP0c512kzkdXq;
 Tue,  3 Nov 2020 17:01:36 +0800 (CST)
Received: from [10.136.114.67] (10.136.114.67) by smtp.huawei.com
 (10.3.19.208) with Microsoft SMTP Server (TLS) id 14.3.487.0; Tue, 3 Nov 2020
 17:01:36 +0800
To: <daejun7.park@samsung.com>, "jaegeuk@kernel.org" <jaegeuk@kernel.org>,
 "chao@kernel.org" <chao@kernel.org>
References: <CGME20201103083832epcms2p6c8b0e4470f1392772317ab2b25256b3d@epcms2p6>
 <20201103083832epcms2p6c8b0e4470f1392772317ab2b25256b3d@epcms2p6>
From: Chao Yu <yuchao0@huawei.com>
Message-ID: <c885ff38-fce2-43d2-cfe1-57e0a3a0b449@huawei.com>
Date: Tue, 3 Nov 2020 17:01:36 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20201103083832epcms2p6c8b0e4470f1392772317ab2b25256b3d@epcms2p6>
Content-Language: en-US
X-Originating-IP: [10.136.114.67]
X-CFilter-Loop: Reflected
X-Headers-End: 1kZsCM-007VWF-DI
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: change write_hint for hot/warm nodes
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
Cc: yongmyung lee <ymhungry.lee@samsung.com>,
 Jieon Seol <jieon.seol@samsung.com>, Sang-yoon Oh <sangyoon.oh@samsung.com>,
 Sung-Jun Park <sungjun07.park@samsung.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Mankyu PARK <manq.park@samsung.com>, Keoseong Park <keosung.park@samsung.com>,
 SEUNGUK SHIN <seunguk.shin@samsung.com>,
 "linux-f2fs-devel@lists.sourceforge.net"
 <linux-f2fs-devel@lists.sourceforge.net>,
 Jinyoung CHOI <j-young.choi@samsung.com>,
 Jaemyung Lee <jaemyung.lee@samsung.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2020/11/3 16:38, Daejun Park wrote:
> In the fs-based mode of F2FS, the mapping of hot/warm node to
> WRITE_LIFE_NOT_SET should be changed to WRITE_LIFE_SHORT.
> 
> As a result of analyzing the write pattern of f2fs using real workload,
> hot/warm nodes have high update ratio close to hot data.[*]
> However, F2FS passes write hints for hot/warm nodes as WRITE_LIFE_NOT_SET.
> 
> Furthermore, WRITE_LIFE_NOT_SET is a default value of write hint when it is
> not provided from the file system.
> In storage, write_hint is used to distinguish streams (e.g. NVMe).
> So, the hot/warm node of F2FS is not distinguished from other write_hints,
> which can make the wrong stream seperation.
> 
> * Liang, Yu, et al. "An empirical study of F2FS on mobile devices." 2017
> IEEE 23rd International Conference on Embedded and Real-Time Computing
> Systems and Applications (RTCSA).
> 
> Signed-off-by: Daejun Park <daejun7.park@samsung.com>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
