Return-Path: <SRS0=wn0m=24=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB46CC33C99
	for <linux-f2fs-devel@archiver.kernel.org>; Tue,  7 Jan 2020 11:38:11 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A9E892073D
	for <linux-f2fs-devel@archiver.kernel.org>; Tue,  7 Jan 2020 11:38:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="WuuR2xLM";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="EYmImVqx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9E892073D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1ionBb-0000dv-9t; Tue, 07 Jan 2020 11:38:11 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <yuchao0@huawei.com>) id 1ionBZ-0000dn-Q9
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 07 Jan 2020 11:38:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 MIME-Version:Date:Message-ID:From:References:CC:To:Subject:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=cpnq1FBeD3DQ+YOhp0Y4fYuWHfvkpM4nVghy1cABqV8=; b=WuuR2xLMGOgKi8o9YTg0Yu+OYw
 paA351G8K9cVE7yFWTNuTXpg6zJp8SLhC7UmoX2evPSfsVnFVf+EFtpJ36q7EO+uGAVVJgg5MquNr
 dpUOlUlqrHLmAqRB6LnD6Q2Y9Zr2m1hpn9avo9144z1Y8J7xvS30F7S0CLE2pVrh8Dls=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:
 Message-ID:From:References:CC:To:Subject:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=cpnq1FBeD3DQ+YOhp0Y4fYuWHfvkpM4nVghy1cABqV8=; b=EYmImVqx9KfFhnEMYszwx3OOLI
 /9bxyk7TlLqRd1S8OcGlwOXZmS9qUgG4PWpYqAxRCJn7GJbYBaBFCoBANT+SR8oAev8xu5ZTPUyxE
 nCM6cXS5s0fbMfyqM0fNDQLuI0+cRfJxT63jF4fp2eTHgbXjibVU2JZbxC47bk8pwxH0=;
Received: from szxga07-in.huawei.com ([45.249.212.35] helo=huawei.com)
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1ionBJ-00CPX8-2D
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 07 Jan 2020 11:38:09 +0000
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id 845B656D4FB73F553C27;
 Tue,  7 Jan 2020 19:37:44 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.208) with Microsoft SMTP Server (TLS) id 14.3.439.0; Tue, 7 Jan 2020
 19:37:41 +0800
To: Chengguang Xu <cgxu519@mykernel.net>, <jaegeuk@kernel.org>,
 <chao@kernel.org>
References: <20200104142004.12883-1-cgxu519@mykernel.net>
 <20200104142004.12883-2-cgxu519@mykernel.net>
From: Chao Yu <yuchao0@huawei.com>
Message-ID: <56985674-6c24-3332-7542-33e850942f57@huawei.com>
Date: Tue, 7 Jan 2020 19:37:40 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20200104142004.12883-2-cgxu519@mykernel.net>
Content-Language: en-US
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
X-Headers-End: 1ionBJ-00CPX8-2D
Subject: Re: [f2fs-dev] [PATCH 2/2] f2fs: code cleanup for
 f2fs_statfs_project()
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
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2020/1/4 22:20, Chengguang Xu wrote:
> Calling min_not_zero() to simplify complicated prjquota
> limit comparison in f2fs_statfs_project().
> 
> Signed-off-by: Chengguang Xu <cgxu519@mykernel.net>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
