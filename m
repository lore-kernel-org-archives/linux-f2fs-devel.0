Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B517D2ECE9
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 20 Jan 2026 12:27:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Content-Transfer-Encoding:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lRW5HziAtjRXXE82y3F67i/h5pFH+xCUqHzjknDiK+M=; b=Dy6OTc93DWiiPS+OgDDFPr2duk
	CeELfekU+3Uepv23nm7B5WPjS7yrtHgHGCg0cRXE9U/nJ9TtSuruqAS/hUDqkJ0Bgk9nPXau5a4go
	jhvK0VPJCF5u+iQwmYeU9+5sJtA1Rxw/qc6d/bN1vXPPnuQa2auOBWd5pfHGSAzM4bsA=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1viApc-0005rW-Ne;
	Tue, 20 Jan 2026 12:27:36 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1viApb-0005rP-VJ
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 20 Jan 2026 12:27:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=8h5mXVa/bTW4HlkufZlyr2UljPRvSPOyde+KHbfrjhI=; b=Jf1OSLOVamQ3J0qnIdVeH2ou4l
 jdftJAKLJdCS8l4xZ6DHFEdu/iMyfHCto0nwb1PncWSETcETDRmK0UQN5MRE5fF7vDRAZxC7EzcGg
 rGLLzDIaSB91Zx746gMm/db2EkoORewZ5DtyFV+H7a/PucrzZA76ptfGPZS+SHcVFMxM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=8h5mXVa/bTW4HlkufZlyr2UljPRvSPOyde+KHbfrjhI=; b=SyCfrsjbwIr1hcOFAqngius750
 4uWugHI9gtzB0IgeHryRW/S3zT5AmRsgjz3BUbfyCzfNwD8sD1GRLspkK00yLZDVDX572JFOhVjyI
 4u8pJwu9bllg8Sv0aELryEXkIs9JKD0/d3c7010zDg6FRTh61e1UhPAssVklraB5ppAM=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1viApb-00026L-Iu for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 20 Jan 2026 12:27:35 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 084CC60008;
 Tue, 20 Jan 2026 12:27:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3F05C16AAE;
 Tue, 20 Jan 2026 12:27:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1768912049;
 bh=WdiBaEFDDgiYbwlOof8d1knHHV2Z9/xrsdmM6mlrLho=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
 b=i5QQL9YCPlP1bb6MvtP6yZ8D1mGRAK1M3KgAQQvU6Pt3/70ytS2UTh+wx5pwoGA6X
 lbnXyHLMR0778qPbmLHovem0cp54MTqvFxgIA4pUTbjKGCCc89Ll/SUmxs/h72rbh2
 GQNC4heF25QYUonT73D0REjzmPF7E+qAUAeVGoP9WgRV8uuoZCW2vFkFbcwRv4gevY
 iYspoWJNCJ7ScIxoDlHzndsg+LIBAdJsCaun/ldzymauduz8o+i7hrkpbNnLLw7z4D
 SYB868Jg6SM+hOdswk1fz7u/NVe87aiBvVOupQHCwXg9Ofbwj6+NU2aQz7cxD9JflL
 GEThT8zpfVjHQ==
Message-ID: <002df972-0217-4e1c-b17b-7739ccfc27c6@kernel.org>
Date: Tue, 20 Jan 2026 20:27:27 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Yongpeng Yang <monty_pavel@sina.com>, Jaegeuk Kim <jaegeuk@kernel.org>
References: <20260113152138.15979-2-monty_pavel@sina.com>
 <20260113152138.15979-4-monty_pavel@sina.com>
Content-Language: en-US
In-Reply-To: <20260113152138.15979-4-monty_pavel@sina.com>
X-Headers-End: 1viApb-00026L-Iu
Subject: Re: [f2fs-dev] [PATCH v2 2/3] f2fs: change size parameter of
 __has_cursum_space() to unsigned int
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
Cc: Yongpeng Yang <yangyongpeng@xiaomi.com>,
 linux-f2fs-devel@lists.sourceforge.net
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 1/13/2026 11:21 PM, Yongpeng Yang wrote:
> From: Yongpeng Yang <yangyongpeng@xiaomi.com>
> 
> All callers of __has_cursum_space() pass an unsigned int value as the
> size parameter. Change the parameter type to unsigned int accordingly.
> 
> Signed-off-by: Yongpeng Yang <yangyongpeng@xiaomi.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
