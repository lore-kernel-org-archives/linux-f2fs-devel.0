Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A676F606A31A
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 29 Oct 2026 01:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=YnlVP51O;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=dVi0en/Q;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=QW2B2Ai5;
	dkim=neutral header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=goFftCYb
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=cpqm/pKWu1thPpWZhJ2XYXHe6ST+gGH12TI/g1ftqaY=; b=YnlVP51OcGFQzn
	6CRKzkXM91JNncj7IUaVDPIIf/7yJlZQcpuLOBESMbAZawopU0hm6U+T6nc2urd3nNSgL0/45tL0q
	v2A9il/rP5t6MFwVaPbW99eXDkIHldNFqpOgv1wOf8m4n5dcpEDLz92CxP4752eUXUlT3xzeQaSyN
	dKs=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xMEzH-000000003Yu-1P5v;
	Thu, 29 Oct 2026 01:31:27 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <chao@kernel.org>) id 1xMEzF-000000003Ym-3lMQ
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 29 Oct 2026 01:31:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=zF1LbWjI2Ky7xvAGGgZGckaS30gdrfCaUY7oUIJ7sFM=; b=dVi0en/QAZ6qoNU4f1QkXJAiw2
 1ePGahdJytXIPRxE/VIR3+V72NYvncOekldkcvogNW3O3vRVSFrl9QquFujlazpV900Z+HpMkbYoZ
 hBDfFSdQBIARqxxr+9/gWSpWemmbpPv83gBvJCFCOp67q49SION75roJW3Tyh/lW3tFw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=zF1LbWjI2Ky7xvAGGgZGckaS30gdrfCaUY7oUIJ7sFM=; b=QW2B2Ai5aL3Er+IVdAk/yGLf7s
 0SwBQJ1MfvWnRWY4avczcfXXGmkixkstJnv1tEToCpZVNYTd9HAZ1nLv1qwhemsJxX7NsLznPX4WY
 74CBcCLLIC2ruOfbuYRo6PeJjKu3O06UaaQK3Puw6RbPTRRvsSaNoIyv84dRGhCV8aRo=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xMEzB-000000008Hk-21jL
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 29 Oct 2026 01:31:25 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id E0AF9600D1;
 Thu, 29 Oct 2026 01:31:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AC8B1F01825;
 Thu, 29 Oct 2026 01:31:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793237475;
 bh=zF1LbWjI2Ky7xvAGGgZGckaS30gdrfCaUY7oUIJ7sFM=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To;
 b=goFftCYbm+xFWsw2EfmZUDSNNOMR0L6I8n+g48eyn2L1FQprUtRwecj+YQWjMV2wE
 jMBvqC4EZ9lb2DuJRLeaqPADeEXFN/EXDOh7bPan3sHiB3op40Ccp9ajHSckkyrW6C
 UEk/+uY1kuCTjYLiIasIJrOn8GUjtBi1CyPZ8tsrCgv8gIAe+utW2k0rYix1rqblww
 UwuQAAZC5kdgRt+9Kqo7mDKWdZ/6lKBQ4BdA56boChaC1Gh4r/J1xCyhgve6FMPZwB
 eNasXBCEKz0NaIE4nKp1LI2tHx3RpdHBlyq1MHAsVWdVR5dOhI3EMDos8Y2eFPy81m
 VOpq4ZJt45ViA==
Message-ID: <78d734ed-55fc-4f42-b85f-79dd1715555c@kernel.org>
Date: Thu, 29 Oct 2026 09:31:11 +0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Nanzhe Zhao <nzzhao.sigma@gmail.com>,
 linux-f2fs-devel@lists.sourceforge.net, Jaegeuk Kim <jaegeuk@kernel.org>
References: <20261028154407.1601430-1-nzzhao.sigma@gmail.com>
 <20261028154407.1601430-3-nzzhao.sigma@gmail.com>
Content-Language: en-US
In-Reply-To: <20261028154407.1601430-3-nzzhao.sigma@gmail.com>
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xMEzB-000000008Hk-21jL
Subject: Re: [f2fs-dev] [PATCH v8 02/15] f2fs: carry subpage offset and
 count in write IO
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

On 10/28/26 23:43, Nanzhe Zhao wrote:
> From: Nanzhe Zhao <zhaonanzhe@xiaomi.com>
> 
> Large folio write paths need to submit I/O for a range inside a
> folio instead of always submitting the whole folio from offset zero.
> Add folio_offset and folio_blkcnt to f2fs_io_info to describe the
> block offset inside the folio and the number of contiguous blocks
> covered by the I/O.
> 
> Apply the new fields to the bio submit paths that need the subpage
> offset or contiguous block count.
> 
> Signed-off-by: Nanzhe Zhao <zhaonanzhe@xiaomi.com>
Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
