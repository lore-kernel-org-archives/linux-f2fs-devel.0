Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 583B6606A31A
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 29 Oct 2026 01:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=I1CYs/V0;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=nCPhAbqU;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=BUR+oOdK;
	dkim=neutral header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=O9ad2XBa
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=be5aBYz6/McphhwUA+vOriX5nhFAmYcepVp+ZPtUGyU=; b=I1CYs/V08Sq9aK
	1p4TQlPKAFNAgpe9tzUnzCQTanGC97tWskDW2s8DYlw1mxRzphiIP7xVsPzOXTw+SjZ71Ljyq6B9y
	l53/HG5Pny4tD4vxfO1LrHVLbdUjWhD1winqmeBaDvgDdsQw5zW7lWlXudrDHpV3u8RMlOVNVAvMI
	G5Y=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xMF2N-000000006jq-0JEt;
	Thu, 29 Oct 2026 01:34:39 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <chao@kernel.org>) id 1xMF2L-000000006jU-0zwG
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 29 Oct 2026 01:34:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=kFqYnLkny1QhGh+grTggM9at/kp84YzwzVgRpPpjNx4=; b=nCPhAbqUe4T/VygKkdGWZUmSma
 dBPc4dCuXtwqD+qLjEkyews5yHQY0Im5mQQf6az6Fum61tAV+DVQogL7dVd/DcYDMCwKOln19HxLU
 FkOOQbSIvrQ0g9X5XiVqA/LIPSK5kIhaSMbUNcwQYI/hchLXLfinb7LRNDjjUfW4rwaA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=kFqYnLkny1QhGh+grTggM9at/kp84YzwzVgRpPpjNx4=; b=BUR+oOdKO3TFvD+rDBSAVq8EiI
 QzCtDE1og0r+wPotBKMdXm2S0LhkS7yqB1mcCGgqsA4czhqlOqsrFNo5wAuuAUv2VasvOh7uZ9YVZ
 rqjB4wRYD24f75SmFpWVNUj4OGsjECVTujU+HT3O3jOd4lu1z+zUL29Y+sXnCXo4yHd4=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xMF2F-000000008Ot-0eMv
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 29 Oct 2026 01:34:32 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id CFF404394F;
 Thu, 29 Oct 2026 01:34:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 217B61F01825;
 Thu, 29 Oct 2026 01:34:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793237665;
 bh=kFqYnLkny1QhGh+grTggM9at/kp84YzwzVgRpPpjNx4=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To;
 b=O9ad2XBa7bo/1WrsM+XrLEUcBgjn5hFxXY66xO1JQCI5uDBB74wX1Y0RLZ/CApVur
 1Gm77GhZuNGb6UM0fNPB/zbWfVWm1no2rrNA9lSHCkvxYEtrMqNVNEMwAILlh4Wlhk
 7OSw16UPY5OmLGlqL8CuVIGo5YJGox1tCv5Qx9Z3wBurMQaDVyoBa6yJXoHVhQ6Kw4
 VXrqQtxJAX5AJ3M7KOJK5KGw4VODlDqJ+gC6L4uDIUwB+XqLGtd92iibmYCGqBi4N2
 w44SPLTE4P+VGYzjY5NRSHni+8RIucPU/G8iqlpD5x7hDscNeT38Qu6DyWnTdLnMnv
 T96CtfNjDzNFw==
Message-ID: <e2cd3f8c-b233-43fc-a3af-e0585483fe13@kernel.org>
Date: Thu, 29 Oct 2026 09:34:21 +0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Nanzhe Zhao <nzzhao.sigma@gmail.com>,
 linux-f2fs-devel@lists.sourceforge.net, Jaegeuk Kim <jaegeuk@kernel.org>
References: <20261028154407.1601430-1-nzzhao.sigma@gmail.com>
 <20261028154407.1601430-13-nzzhao.sigma@gmail.com>
Content-Language: en-US
In-Reply-To: <20261028154407.1601430-13-nzzhao.sigma@gmail.com>
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xMF2F-000000008Ot-0eMv
Subject: Re: [f2fs-dev] [PATCH v8 12/15] f2fs: fix zeroing paths for large
 folios
X-BeenThere: linux-f2fs-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
From: Chao Yu via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Chao Yu <chao@kernel.org>
Cc: Barry Song <baohua@kernel.org>, Juan Yescas <jyescas@google.com>,
 Daeho Jeong <daehojeong@google.com>, linux-kernel@vger.kernel.org,
 Dev Jain <Dev.Jain@arm.com>, David Hildenbrand <David.Hildenbrand@arm.com>,
 Pengfei Li <lipengfei28@xiaomi.com>, Bo Zhang <zhangbo56@xiaomi.com>,
 Kalesh Singh <kaleshsingh@google.com>, Nanzhe Zhao <nzzhao@126.com>,
 Nanzhe Zhao <zhaonanzhe@xiaomi.com>, Ryan Roberts <Ryan.Roberts@arm.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/28/26 23:44, Nanzhe Zhao wrote:
> From: Nanzhe Zhao <zhaonanzhe@xiaomi.com>
> 
> Several f2fs zeroing paths still use PAGE_SIZE based offsets after
> a file mapping can contain large folios.  This is fine for order-0
> folios, but it zeros the wrong range once the target block is not at
> offset 0 in a large folio.
> 
> Use offset_in_folio() to translate the file block index to the folio
> offset before zeroing data in truncate_partial_data_page(), fill_zero(),
> and f2fs_get_new_data_folio().
> 
> Signed-off-by: Nanzhe Zhao <zhaonanzhe@xiaomi.com>
Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
