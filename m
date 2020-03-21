Return-Path: <SRS0=RYwi=5G=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1376C4332B
	for <linux-f2fs-devel@archiver.kernel.org>; Sat, 21 Mar 2020 12:38:34 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9197020754;
	Sat, 21 Mar 2020 12:38:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="DI1FosJl";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="JubVcTW4";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="wg0BZOyQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9197020754
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1jFdOc-00039v-7a; Sat, 21 Mar 2020 12:38:34 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <chao@kernel.org>) id 1jFdOb-00039p-Vr
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 21 Mar 2020 12:38:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 MIME-Version:Date:Message-ID:From:Cc:References:To:Subject:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=zp2n1MEssNtUaVqT85o+OvS2O3s3EUm4WEI+nLhZGcA=; b=DI1FosJlcZb8R6vJ/UqBP46D+7
 EIUR3h+wgNVK/YHLlQKcUPOmBmLiFiYxJC01q53NY8WUkEEt/p3cSdM2prloRZ4/3Ww1WetS7RlF0
 zdv7PdmvdC8sjLHq/joxBCNzYcZPy3+jsujGjV69CmjMrmMS7GC8V0KA+Yer8IU2Z8Tc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:
 Message-ID:From:Cc:References:To:Subject:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=zp2n1MEssNtUaVqT85o+OvS2O3s3EUm4WEI+nLhZGcA=; b=JubVcTW4nIuHY4yCAmsO3oJKOy
 NODLfLa809KM72bH+4wqG6P3DYwFuA3CaCifIitqiQtHMKpDfrb5OPBnF2m6UCpGQt5qAWQnVL1Hv
 LpdqG5F/P/AmRfq3mPcVPVAJ++JjgiWMSv5R36WsaeJLWCwDhJLd2TFTRXMSIfh1qkq8=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1jFdOa-00BNdC-Tm
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 21 Mar 2020 12:38:33 +0000
Received: from [192.168.0.107] (unknown [49.65.245.234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id A9EFD20754;
 Sat, 21 Mar 2020 12:38:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1584794305;
 bh=zp2n1MEssNtUaVqT85o+OvS2O3s3EUm4WEI+nLhZGcA=;
 h=Subject:To:References:Cc:From:Date:In-Reply-To:From;
 b=wg0BZOyQxkJPeGA6fMlf8DP3FnZm25yOoGK8F4EgvgaHjCd9lK/nlsw/qOgvlrhRT
 6g3ukkYCrGg4mHygVxRsdOHXGALoxh5W7NiPs4ZXnzM1hOpXl45tysIblZC1s7vspe
 QJhVI4uupeoTC2/6pjQQHfIwaDfJfrSYhoqespzM=
To: Matthew Wilcox <willy@infradead.org>,
 Andrew Morton <akpm@linux-foundation.org>
References: <20200320142231.2402-1-willy@infradead.org>
 <20200320142231.2402-19-willy@infradead.org>
From: Chao Yu <chao@kernel.org>
Message-ID: <2796a575-dd89-6cfb-a7af-511a2f463fda@kernel.org>
Date: Sat, 21 Mar 2020 20:38:19 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <20200320142231.2402-19-willy@infradead.org>
X-Headers-End: 1jFdOa-00BNdC-Tm
Subject: Re: [f2fs-dev] [PATCH v9 18/25] erofs: Convert uncompressed files
 from readpages to readahead
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
Cc: cluster-devel@redhat.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org,
 William Kucharski <william.kucharski@oracle.com>, linux-btrfs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
 linux-erofs@lists.ozlabs.org, ocfs2-devel@oss.oracle.com
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2020-3-20 22:22, Matthew Wilcox wrote:
> From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
>
> Use the new readahead operation in erofs
>
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Acked-by: Gao Xiang <gaoxiang25@huawei.com>
> Reviewed-by: William Kucharski <william.kucharski@oracle.com>

Reviewed-by: Chao Yu <yuchao0@huawei.com>


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
