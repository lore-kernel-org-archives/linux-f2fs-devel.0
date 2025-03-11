Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D19F1C282EC
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 11 Mar 2025 11:49:29 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1try6z-00035g-GU;
	Tue, 11 Mar 2025 11:49:29 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1try6y-00035a-2D
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 11 Mar 2025 11:49:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=R8Q9TUFUcmUCmJa8fuQjdoN8lxpUwl7YK8Kj11w5jfs=; b=FAUdoLqM6ORRiXBxqoTiXySjqh
 NW0i4/Myh89Q/O3dzyMOPZtQ3yDF/Sbq+f2eSsHej5otZWmhKOiBY7jzbYrECRCKtikicLjFRNyNa
 0IIYKpixDKgacsGEHx5DkiNo/Rg0By0Z8x3S1sET7/b0lLWm8HivLCaPquMmfyrpce1M=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=R8Q9TUFUcmUCmJa8fuQjdoN8lxpUwl7YK8Kj11w5jfs=; b=XwUaE3aUS3vSdcwZe2YOIag0xp
 s35CIqKQ6nC46/Z9ACR/twiuCNyCgXAtvuXEQJJDLEQKg9Hcaswlm/LCqJQDyclESX5y6Hx9tIEA+
 8LP3V7yCiGM+53FgAqCvotCQPYzk9qZTu48PpQqU+yDJNs65j2ULv+bdPo+rytEE93FM=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1try6s-0003Up-Gw for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 11 Mar 2025 11:49:27 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 5D0C45C60E5;
 Tue, 11 Mar 2025 11:46:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DD17C4CEE9;
 Tue, 11 Mar 2025 11:49:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1741693751;
 bh=RtjSiZtx5omuFVg3avMcut1p0gnfZssAhseajHHPr5c=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
 b=afnQ3xQ+6T+/rweyszaV5KAUraFYtibSpTjHU75K27TTjSpEkxIHS0Oc2LY93X0zf
 YHY/9Ay7ij4v3QvW6AIIkcTrKgwwRVx5u1LslNyvrttk1uWwwenGQ90C8pqsiJ71in
 jMrQ96ygv9MeGn+V9Al3uiv5i5Y5ETKByDdZbMQE+dn8GX7K/IcPyG4osmWUgXcmyZ
 +FTbs0I6dcnBPvmwsd+Rv7YgjSBaCfagYXcZDG+b34KZjpddOuoFjNM2HrFEyDfb/l
 H2zNr7/tVpYnK0WQFlsDPBWWAnEhapmk7YBUUyX+Mg/9/3vO30lj/SF7iH4SmBZi7d
 koA2mpxEztEUA==
Message-ID: <e633ffab-0731-433f-82e4-44477b1f96e9@kernel.org>
Date: Tue, 11 Mar 2025 19:49:08 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Jaegeuk Kim <jaegeuk@kernel.org>
References: <20250307182151.3397003-1-willy@infradead.org>
 <20250307182151.3397003-4-willy@infradead.org>
Content-Language: en-US
In-Reply-To: <20250307182151.3397003-4-willy@infradead.org>
X-Headers-End: 1try6s-0003Up-Gw
Subject: Re: [f2fs-dev] [PATCH 3/4] f2fs: Remove f2fs_write_meta_page()
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
Cc: linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 3/8/25 02:21, Matthew Wilcox (Oracle) wrote:
> Mappings which implement writepages should not implement writepage
> as it can only harm writeback patterns.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
