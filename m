Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA5FCC5DF81
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 24 Aug 2026 08:53:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Content-Transfer-Encoding:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=P2qyq8N5Tq7w+RdUHt1/95dG1CbH21VrSW0OmYx91Q4=; b=KWTOiD/qkxgesFtiuSbB4LY6cR
	XeGy04EBF1NQZYhBnu3Jm6Ze1btkqVgY8AbgtfRPy9dIVht++XclUUGsfNS5+lpkOu8lQSc+Dcxsw
	T6XJbcO3njTRZGVi+ie33IhhCvcVDNUtZShdvq4tHLOLanz/5byHW+jtE7Ffj1D3SSW4=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wyQQw-0006Cx-KX;
	Mon, 24 Aug 2026 08:53:32 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1wyQQh-00064w-Ia
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 24 Aug 2026 08:53:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=WFecKIK1PJcHmVFcLdR//8ys7vYPyoBgiIwphMnMYGQ=; b=R5yyW5NrzTjpJItnoOf45/fZ1o
 4xnrK00F/huESax4v8t0BTv2XFjSpzxxZkWsz+UkSGAUncVDrlvShVVPNau4hx8tU/r0AYqDnROTk
 4yr2ykQstSqyx28fwSkF7+zX4ZLwDr7Ar4ahoGRgRhjD7x6wcte27k0DXYoV58GRtqaA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=WFecKIK1PJcHmVFcLdR//8ys7vYPyoBgiIwphMnMYGQ=; b=h54PhZ1wyB651hUm/9K37juxx6
 4CgY9/yK2mnuARwN9o69XYU6gXgzyWwkFTwNN//RKRNuvqnGMtRKjpHbeGUBjqMCNXurbsOMrAfqI
 CSu3Jz3WnDatYoSYzpBZqnCEXpYZuiQ07xhI2mxOhUOF5OIiscQ9Gy4I7GicadHtlHEY=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wyQQd-0006PQ-MT for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 24 Aug 2026 08:53:17 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 4E04140950;
 Mon, 24 Aug 2026 08:53:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F19F1F000E9;
 Mon, 24 Aug 2026 08:53:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787561590;
 bh=WFecKIK1PJcHmVFcLdR//8ys7vYPyoBgiIwphMnMYGQ=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To;
 b=gwPtful9/Eyr6DlHaUmu1ixqPll+CrUh8iM4+xTh1bLrGisuTvcnfkmcmtCN0AggR
 pdJ/0EcAw2Bex89z/tjW+ThJhV9roSAslPogdAZnUdBendKAHEcFUiD6nblGqY5O8+
 Y4SzdZ2eq6VmXqpn9xgwj9rTxK66fm5E1aThhwp+ep39czj9xBQ2iexVED/YIXHFE2
 gxK737dJ+YIAYusilmqazpH3sTbKNaUw5lhb1Ql9BAXzqkZC7kpna/WwibzSFL/O1i
 AenmQwlcHz0BcfCb/mm1NtaRKEGDen8dLFIeJJOPP7c/qLLMV44M4W9kYxevwvx9tv
 uriqFEp+4IPtQ==
Message-ID: <0229529e-03e0-4684-a8c5-015113858640@kernel.org>
Date: Mon, 24 Aug 2026 16:53:06 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Seongjae Jeong <jsjlee1020@gmail.com>, Jaegeuk Kim <jaegeuk@kernel.org>
References: <20260824023231.24616-1-jsjlee1020@gmail.com>
Content-Language: en-US
In-Reply-To: <20260824023231.24616-1-jsjlee1020@gmail.com>
X-Headers-End: 1wyQQd-0006PQ-MT
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: use adjusted write range after
 f2fs_write_checks()
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
Cc: Daeho Jeong <daehojeong@google.com>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 8/24/26 10:32, Seongjae Jeong wrote:
> generic_write_checks() in f2fs_write_checks() can adjust iocb->ki_pos
> for append writes and truncate the iterator to limit the number of bytes
> to write.
> 
> In f2fs_file_write_iter(), the pinned-file overwrite check currently
> uses the position and count saved before f2fs_write_checks(), so it
> can check a range different from the actual write range.
> 
> The forced buffered I/O cleanup also uses orig_pos saved before
> f2fs_write_checks(). For O_APPEND writes, this can make the cleanup
> flush and invalidate the wrong page cache range.
> 
> Move the pinned-file overwrite check after f2fs_write_checks() and use
> the adjusted iocb->ki_pos and iov_iter_count(from). Also save the
> adjusted write position and use it for the forced buffered I/O cleanup.
> 
> Fixes: 3fdd89b452c2 ("f2fs: prevent writing without fallocate() for pinned files")
> Fixes: 92318f20d703 ("f2fs: preserve direct write semantics when buffering is forced")
> Signed-off-by: Seongjae Jeong <jsjlee1020@gmail.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
