Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72C9DC982DA
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 21 Sep 2026 02:52:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Content-Transfer-Encoding:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=IpFShaOmR6+xH1ceuy97JyHb+uAv9kFm9aYEJ4g4zOk=; b=WtjaNX6+AhQeXyXX/FDqiCx0uz
	o5MGxVgs55NPQdbr6veN8iYZSxO8h2W2XPp7d96LSHbmYyKdVZOVRL5c+9OnT/4+2CLdOUpCIFFpf
	wVa5fRs1kjYjd8bVLcEkEj7yqNN3uISw/Hwntb00FsXWK26iAMseXC9Maxya/WtqaTpk=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1x8U90-0001RN-4r;
	Mon, 21 Sep 2026 02:52:38 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1x8U8z-0001RG-5H
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 21 Sep 2026 02:52:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=sJB1bkNOzZgQq+4H9QThVYJkqDHUdc9VU/5nM8apPNQ=; b=MQC6R3wjsMKQOcPVPYx4h9mKNH
 ui3JXz23c9CsPPbJ/r941N+VmFDh7APHYwC2qFcCMDdnuitE0wr2ImB2pIHnomc7lAYrNFB5ue6a7
 SP1wSkRq/NgZxYJVEJkrRheZyBlkZps+sPfcZvED6Z73XWXqe+GXd2vpTeYcEkLFjmTU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=sJB1bkNOzZgQq+4H9QThVYJkqDHUdc9VU/5nM8apPNQ=; b=eAluz0EX60kO6Vv4i5wP1iOWkN
 FxJeIV+35b5qNfFsXbhFKTNWtky5hLOEeT9cmH/O27Ya0SBIb8hGPQqYcS5tAGkgeXCuI4Qs2VFct
 wvDwD2qoIcZAOhqLKHlu8QuIGHVfhnzKHhBBO8+Jjvz10k6KnHJr6ZbDlk4Wa+Wl4euw=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1x8U8x-0001oS-J7 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 21 Sep 2026 02:52:37 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 284B942DF5;
 Mon, 21 Sep 2026 02:52:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E2451F000FF;
 Mon, 21 Sep 2026 02:52:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789959150;
 bh=sJB1bkNOzZgQq+4H9QThVYJkqDHUdc9VU/5nM8apPNQ=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To;
 b=KMyf3zp+BzUf2/ainezMeCzrw0meSHq16lh8eMdy5NkZLizooTzv7D9rw9CZ5mJmy
 DMdfio9CN3R8nRwGhcomkLk7CKhp+PvpZAUVRSD+ciH0RXfQSGUv7p1hxhll8qNalK
 kIDLO/AUsN8tYN7RjYaHFQWtvD/0MnEOfOJ/n6mZkvDDnPxaeON5/yaj2VKBdGUsH1
 uYnFm7gsxSJrsk1oIjBdQo6/5nAcEdWPgfj3xirwEb70XD73B30UKAc0eSn0Bu5DiZ
 hCMucMB8j/kRz6b3ZY2svy8NMiQxIBIwhK7lnFfHdfbh1zqkQrTasPQF0xqWsppWll
 nicU6RZQLmskg==
Message-ID: <b77fc4a3-0c8f-4470-bc0f-f9d7cd819885@kernel.org>
Date: Mon, 21 Sep 2026 10:52:24 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Nanzhe Zhao <zhaonanzhe@xiaomi.com>,
 linux-f2fs-devel@lists.sourceforge.net, Jaegeuk Kim <jaegeuk@kernel.org>
References: <20260915041909.2903887-1-zhaonanzhe@xiaomi.com>
 <20260915041909.2903887-6-zhaonanzhe@xiaomi.com>
Content-Language: en-US
In-Reply-To: <20260915041909.2903887-6-zhaonanzhe@xiaomi.com>
X-Headers-End: 1x8U8x-0001oS-J7
Subject: Re: [f2fs-dev] [PATCH v2 05/14] f2fs: support large folio writeback
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
 Dev Jain <Dev.Jain@arm.com>, linux-kernel@vger.kernel.org,
 David Hildenbrand <David.Hildenbrand@arm.com>, Bo Zhang <zhangbo56@xiaomi.com>,
 Kalesh Singh <kaleshsingh@google.com>, Nanzhe Zhao <nzzhao@126.com>,
 Pengfei Li <lipengfei28@xiaomi.com>, Ryan Roberts <Ryan.Roberts@arm.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 9/15/26 12:19, Nanzhe Zhao wrote:
> @@ -3799,7 +4198,10 @@ static int __f2fs_write_data_pages(struct address_space *mapping,
>   	account_writeback(inode, true);
>   
>   	blk_start_plug(&plug);
> -	ret = f2fs_write_cache_pages(mapping, wbc, io_type);
> +	if (mapping_large_folio_support(inode->i_mapping))

if (mapping_large_folio_support(inode->i_mapping) && !f2fs_has_inline_data(inode))

As we need to writeback inline data into inode via f2fs_write_cache_pages().

Thanks,

> +		ret = f2fs_write_cache_folios(mapping, wbc, io_type);
> +	else
> +		ret = f2fs_write_cache_pages(mapping, wbc, io_type);
>   	blk_finish_plug(&plug);
>   
>   	account_writeback(inode, false);



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
