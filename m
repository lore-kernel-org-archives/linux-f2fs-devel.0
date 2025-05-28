Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B1BDC3ABB2
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 28 May 2025 07:27:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ovX6GhwU4CkqM1dxsV22usHXkPA2MnOoLx6H6pj3+r8=; b=Df8OZzL8+woyO0h96ksyYUaZEM
	M1sshQv91mRf3A9z1qZ5qtkpd1xaLIU/PNB3MHdUs3WzQ4BV2h0IXy5taQns2v/bnHbDYJvdHtv1b
	C6j2t84FyNo+I6Hg/YSqr1iJ/Y+VIkf7hAqCQxQK3I78m9rXqmW0LYxVXThOvTtt2eo0=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1uKBBo-0000KJ-Pk;
	Wed, 28 May 2025 07:27:04 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1uKBBn-0000KA-14
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 28 May 2025 07:27:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=jiyi+3Ec4qGdxa6c/80yEnYGZ9KK79mcjkOjgvHyKh8=; b=iE0YMhQgZ+IdLxfQ/iJ5Ce2kiA
 dHRP/I1kU97JxCCBSVU3psNIw9ffKTEqCCuNlm/RaiB3gYutrICJLwcDaCIOiXuMqgsng5JgQ/sW8
 VPOh9Kn2UwZ1Aic3RxSmF48N/jRiCo3VKYTLErTApQ8866Xm6AptCLdycA/cjgnXI0nU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=jiyi+3Ec4qGdxa6c/80yEnYGZ9KK79mcjkOjgvHyKh8=; b=moAlQsrvEs6cXvHYykuR07o58I
 omxdjudqG4vS8euDdwIlySP9D0QZjrhwOsjJzTMz43IRJiAPu8g+7MRRBztaz+EiXMkwZGdnafykz
 gjexWV4UcQI3Bqt8HgzSf/DxfY5Y+4Ihxjj5k1nI3WiGGPfhUamhbhIb4KijqTB/UjAU=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1uKBBm-0006tW-CH for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 28 May 2025 07:27:02 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 00A555C06DC;
 Wed, 28 May 2025 07:24:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FD25C4CEE7;
 Wed, 28 May 2025 07:26:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1748417211;
 bh=FVKyMWpNPzvSR7svhxr8Oo6IbwStsMjYKVoyHU2gqfc=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
 b=GrFQJ86CJfW3LnlgJQ8p04zT1DZ0xD8I3OkZMnjL+bpnKYTt7LHyY3yeIZD2dlnx/
 HWQAVNGak0WqGP6DtIh9b1XSM7bT8nwHmfTKK/AVwy5HbcOkN4fMbcDYquZW2YVMyC
 ejBHwf/3zmM9vzlG6vPKq72ALWw6dbeh0S+cSw8Das3nEXe1OCTKJvQo38A3a5RW0+
 QPMKGgzlal4AVofLeWm2sSttzrT09TWMeHkWhfEck3A1FJg9JxP3nw1tR3lwWGx/xn
 Q5Qxp671UZrJeaSQSChXZBJDS8GbPySKdWJWGGy3uMhQe61hMG81FFI2GiQkmGgNxw
 i4L9t6lmyXSYw==
Message-ID: <c454bb4e-0232-425d-b77f-cddcdfcce4a4@kernel.org>
Date: Wed, 28 May 2025 15:26:48 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Daeho Jeong <daeho43@gmail.com>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
References: <20250527165411.3724453-1-daeho43@gmail.com>
Content-Language: en-US
In-Reply-To: <20250527165411.3724453-1-daeho43@gmail.com>
X-Headers-End: 1uKBBm-0006tW-CH
Subject: Re: [f2fs-dev] [PATCH v3] mkfs.f2fs: ensure zone size is a multiple
 of segment size
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 5/28/25 00:54, Daeho Jeong wrote:
> From: Daeho Jeong <daehojeong@google.com>
> 
> Otherwise, it doesn't work with a crash.
> 
> Signed-off-by: Daeho Jeong <daehojeong@google.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
