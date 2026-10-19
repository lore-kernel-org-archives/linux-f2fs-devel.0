Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68E1ACCF2D6
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 19 Oct 2026 11:52:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=pdnhgvrzdEilR8clKghTcUWioEsOaebmnTeOkvcTvHc=; b=AKcDcpyPui/71w/Qbfe+qFiO5F
	Bam0hy95RUhV9LsQrGdGIAmL4G0PwAmYzzMKEnI+A/w8ZdlVuMbH2rdZMvlqWhOPL2XXWpynWIEfi
	AKTd3pOT3TRNRYT2NfKc6HigQwKimbBJpCW2FeOwUT7jTTrENBAIZaLexMVmbIxwlPbc=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xIlvG-0000fZ-BG;
	Mon, 19 Oct 2026 11:52:58 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1xIlvE-0000fP-M1
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 19 Oct 2026 11:52:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=KpX9ATZMQwAwGmffhR7W9Exlbrhcs96ouUDOfF+OaLU=; b=jihOkfXqmqPMhDnOyMhb0wprud
 wRts4cKsS3e/8C5z8+Qj5NptgXx3FsUqwRMLCW4U49rlv4+Zx5HwmjDe4ZM4wH+PsNFxP8qw4UZJ4
 Koiff6Ct0fIEsVzLIIg2OvWbhe/VLxiwL/nFv5wkQ5sog+LPobu+kFGmku6NRjxdWziI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=KpX9ATZMQwAwGmffhR7W9Exlbrhcs96ouUDOfF+OaLU=; b=WeE+OC7evVN8Ij/T4A8V+wf04S
 gdKCiL74/jxSD3ITenjeqpiXynMAtdaaz+3UEodBpH7nOyej9JzqBXwzRNcmpPNGtu8XI5X5g0Tkg
 vs6kPhve7DmvqIjIEeoy76SjzDzHhQIWftl8w74UrL1/0u7auEsZFhLNXwqAMB/7OOHU=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1xIlvC-0000TJ-2l for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 19 Oct 2026 11:52:56 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 9AC3640058;
 Mon, 19 Oct 2026 11:52:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 374801F000C4;
 Mon, 19 Oct 2026 11:52:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792410768;
 bh=KpX9ATZMQwAwGmffhR7W9Exlbrhcs96ouUDOfF+OaLU=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To;
 b=VfIg3BJstJ4Y+4iRjf3Ckm0Q9ImVsW9+aR6ZO7TwOxJufIqWjJyEbxMpdZ9IKOKwj
 WM5Wetzdwjr+VBbgVkUXlULNc9qgm3Pv8ZKXvCnS/Cnze/JNHElb1kRvHTPH5w4UzI
 iO3+dlOWTna03plOfGp+8SIv63/0ovOYvekEeUX7+ZINaT15wrDua2VorTqkHmGNDT
 mAQQ75ZfXYcqKjbNaG8gD77RCEGX8Vfq6SjrQ5oIWRLOSa+yzeVL3jnwqMokGfVob4
 etNy8GEM6MJHftctjOXkBwFUv91gRka1FH59FyadhggbtwF8Brp6J9WX+y6kvOvaLB
 UfquaeUYmP9LA==
Message-ID: <36220ef3-5b00-4aa1-ad11-60b10857a886@kernel.org>
Date: Mon, 19 Oct 2026 19:52:44 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Nanzhe Zhao <nzzhao.sigma@gmail.com>,
 linux-f2fs-devel@lists.sourceforge.net, Jaegeuk Kim <jaegeuk@kernel.org>
References: <20261014064445.2835813-1-zhaonanzhe@xiaomi.com>
 <20261014064445.2835813-11-zhaonanzhe@xiaomi.com>
Content-Language: en-US
In-Reply-To: <20261014064445.2835813-11-zhaonanzhe@xiaomi.com>
X-Headers-End: 1xIlvC-0000TJ-2l
Subject: Re: [f2fs-dev] [PATCH v5 10/16] f2fs: support partial uptodate
 large folio read
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
Cc: Barry Song <baohua@kernel.org>, Juan Yescas <jyescas@google.com>,
 Daeho Jeong <daehojeong@google.com>, Dev Jain <Dev.Jain@arm.com>,
 David Hildenbrand <David.Hildenbrand@arm.com>, linux-kernel@vger.kernel.org,
 Pengfei Li <lipengfei28@xiaomi.com>, Bo Zhang <zhangbo56@xiaomi.com>,
 Kalesh Singh <kaleshsingh@google.com>, Nanzhe Zhao <nzzhao@126.com>,
 Nanzhe Zhao <zhaonanzhe@xiaomi.com>, Ryan Roberts <Ryan.Roberts@arm.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 10/14/26 14:44, Nanzhe Zhao wrote:
> +static void f2fs_truncate_read_extent(struct inode *inode, struct folio *folio,
> +				      pgoff_t offset, block_t block_nr,
> +				      unsigned int *len_blks)
> +{
> +	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
> +	struct f2fs_folio_state *ffs;
> +	unsigned int next, end;
> +
> +	if (!f2fs_folio_has_ffs(folio) || *len_blks <= 1)

For newly allocated large folio which doesn't have ffs, we should still update
*len_blks before return?

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
