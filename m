Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B19D5CD98F0
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 22 Jun 2026 03:14:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Content-Transfer-Encoding:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1rK0ot3kVZryJySUXlDwTOvR/VdX4x+PcBDO3063GQc=; b=LHWj3ZvXRimtkn6lUQxhlUGkml
	QDUsqa00nHGRvoNSz5SlFEM7dyw4v3l14LOUP3mlQ/WPtt8gy0q96n+vKwkOy8aSus7aCygAR/v6g
	qzkPXiwkVPa01ARb7GvN0Yz5JSwIGeiGGrlYo7WAiZuQPFbzM7LLtD0NTpQtpfavGd1A=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wbV75-0008Ow-Ks;
	Mon, 22 Jun 2026 03:14:19 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1wbV73-0008Op-KP
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 22 Jun 2026 03:14:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Wg9sImtwFIHijEetl/E4uet0/5PPMDVY/e84ZQ61JV4=; b=UPtMVgNteYL8oK2qccWS8EMFdU
 0aNvam0kLubzwK+x/zaTjGInt/NdA7CjSLtUFKRyh1Fo6vVu+OKTBKHM4SgkVpkWdzMds9iQdylmx
 K1FqqSa7uTWNge/Bq74OtGSXDIEQludSsBU35GAWCqeGA5w/Mqut2afTnPL98g+54CwM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=Wg9sImtwFIHijEetl/E4uet0/5PPMDVY/e84ZQ61JV4=; b=DFuT0GLK/WtEnTnFYFQWupXAtu
 ktXaPl2DXIZHKRYvmy/+W1cSuS0HINlYey9ezHtUymstLEZ0kxQwOfwRNolW0sojax3ClD4Mn0uIm
 gt+QTOvuo6Ep2BanLHsEMdadLEfBaSC4AWgFaGdvVhIuMQguyzCtPhyB/6q9HSVzuif0=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wbV72-0000Je-CQ for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 22 Jun 2026 03:14:17 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 35C5F6008A;
 Mon, 22 Jun 2026 03:14:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 478581F00A3A;
 Mon, 22 Jun 2026 03:14:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782098050;
 bh=Wg9sImtwFIHijEetl/E4uet0/5PPMDVY/e84ZQ61JV4=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To;
 b=UYAHOgu/jbTy3e+/HECL1aZ2xrqshpRiAxeHcyNjDaYfQLEfssPi3D3rbmwFRZZrJ
 qaSYvlUDFWKlddR9AvKMGi/9msFh59TlR57IK4u42COif3rCL4XeprCDfCOzA7r6qC
 bbJIXRhMd51Y+0QuCuDoKS/RMI6tpFR/VMVA7PmLhQLJpD4pcDqTtvnLf9Nt6mvZvm
 RAg7wSbpdWIEivxbhFReX17I7j2PO/JqduGcbflry16EUCYxSOdIAXE+qkOekIyMCe
 ymAFbVsAHjoqszhn5V0dcROXEKYLMCkgPtmPYOP/7SGOoBjNNmtQmeqMMOrO9AeWln
 A8DtrVJhdYm+g==
Message-ID: <d91b17e7-58ff-43a6-855c-bbe7bdb067d2@kernel.org>
Date: Mon, 22 Jun 2026 11:14:06 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Sunmin Jeong <s_min.jeong@samsung.com>, jaegeuk@kernel.org
References: <CGME20260622023853epcas1p3d15698d1e456cc549da18ac2674e1f5f@epcas1p3.samsung.com>
 <20260622023805.3620189-1-s_min.jeong@samsung.com>
Content-Language: en-US
In-Reply-To: <20260622023805.3620189-1-s_min.jeong@samsung.com>
X-Headers-End: 1wbV72-0000Je-CQ
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix to round down start offset of
 fallocate for pin file
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
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 Sungjong Seo <sj1557.seo@samsung.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 6/22/26 10:38, Sunmin Jeong wrote:
> Currently, the length of fallocate for pin file is section-aligned to
> keep allocated sections from being selected as victims of GC. However,
> for the case that the start offset of fallocate is not aligned in
> section, the allocated sections can't be fully utilized. It's because a
> new section is allocated by f2fs_allocate_pinning_section() after using
> blks_per_sec blocks regardless of the start offset. As a result, several
> unexpected dirty segments may be created, including blocks assigned to
> the pinned file.
> 
> To address this issue, let's round down the start offset of fallocate
> to the length of section.

It's good catch!

> 
> The reproducing scenario is as below
> 
> chunk=$(((2<<20)+4096)) # 2MB + 4KB
> touch test
> f2fs_io pinfile set test
> f2fs_io fallocate 0 0 $chunk test
> f2fs_io fallocate 0 $chunk $chunk test
> f2fs_io fallocate 0 $((chunk*2)) $chunk test
> f2fs_io fiemap 0 $((chunk*3)) test
> 
> Fiemap: offset = 0 len = 12288
>      logical addr.    physical addr.   length           flags
> 0   0000000000000000 000000068c600000 0000000000400000 00001088
> 1   0000000000400000 000000003d400000 0000000000001000 00001088
> 2   0000000000401000 00000003eb200000 0000000000200000 00001088
> 3   0000000000601000 00000005e4200000 0000000000001000 00001088
> 4   0000000000602000 0000000605400000 0000000000200000 00001089
> 

Fixes and Cc stable line.

> Reviewed-by: Yunji Kang <yunji0.kang@samsung.com>
> Reviewed-by: Yeongjin Gil <youngjin.gil@samsung.com>
> Reviewed-by: Sungjong Seo <sj1557.seo@samsung.com>
> Signed-off-by: Sunmin Jeong <s_min.jeong@samsung.com>
> ---
>   fs/f2fs/file.c | 7 ++++++-
>   1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> index 2c4880f24b54..3954aea43bd9 100644
> --- a/fs/f2fs/file.c
> +++ b/fs/f2fs/file.c
> @@ -1906,8 +1906,13 @@ static int f2fs_expand_inode_data(struct inode *inode, loff_t offset,
>   
>   	if (f2fs_is_pinned_file(inode)) {
>   		block_t sec_blks = CAP_BLKS_PER_SEC(sbi);
> -		block_t sec_len = roundup(map.m_len, sec_blks);
> +		block_t sec_len;
>   
> +		if (map.m_lblk % sec_blks) {
> +			map.m_lblk = rounddown(map.m_lblk, sec_blks);
> +			map.m_len = pg_end - map.m_lblk;

If pg_end is aligned to sec_blks, but off_end is non-zero, is there off-by-one issue?

Thanks,

> +		}
> +		sec_len = roundup(map.m_len, sec_blks);
>   		map.m_len = sec_blks;
>   next_alloc:
>   		f2fs_down_write(&sbi->pin_sem);



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
