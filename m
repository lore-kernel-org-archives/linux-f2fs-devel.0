Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77961606A31C
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 17 Nov 2026 11:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=j4IqTyo5;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=jdI9Ms8Z;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=lAu2AnZq;
	dkim=neutral header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=btt+oP+s
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=FjUkFN3X9Pc4rsdd0I9Dv0zXtrVOR5B4nw6EJZOBZPM=; b=j4IqTyo5BCw5pA
	DZRsXwoyOM7d3mG28iL0sUKcdijSO0APM3u8ZdRuqWLA+04Xe/NKT3Db9dJPq7wo48KZzcTQzt4yU
	O7tyIMQvf8W3xTqwjyDcGnH7hsUIq5QX5G7XLB6HhX6b8/NOdXjlesP1uo5Vu6UXr3Ct0R9x7GL7z
	0rI=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xTHKR-000000006u2-0rOu;
	Tue, 17 Nov 2026 11:26:23 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <chao@kernel.org>) id 1xTHKQ-000000006tE-1TVn
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 17 Nov 2026 11:26:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=nTKiLpUx3dMnU0ATXQQJ4wXdwToEznpgLoeKZL1liQI=; b=jdI9Ms8ZrCSbzCgMUBz0xBhj1j
 DAglhCrjnEK6h0bnEqxxHmytBdMjXdFtv8v+1ISIwcKn5dqV/bevYpWgkXRImp1KySjMHqVLTY+wz
 1Q3JE1I5Nj7ovdlmEdtZTuepCYsaGtXj2pWaMXWNyyBjatMvBXEbaqvxNcBNqVqvg5X0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=nTKiLpUx3dMnU0ATXQQJ4wXdwToEznpgLoeKZL1liQI=; b=lAu2AnZq6Gxo8iJkHS6O+q9dBQ
 1ka/SEaTesp1eTXhRrjMOP+WWuojnMuLolIjrL9Qx+gXtmw8kIqcMFPhcPLDLS75ADe9TZbHHtmRx
 /LUfR+DHGocNTAKlMWNM6U2Dc9gBz2QAHZuZ3LGsHqGGGVwdniHddy3PjE5LqNzNtnd4=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xTHK3-000000007fj-2adR
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 17 Nov 2026 11:26:01 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 00E5D60629;
 Tue, 17 Nov 2026 11:25:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CE391F000C4;
 Tue, 17 Nov 2026 11:25:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794914753;
 bh=nTKiLpUx3dMnU0ATXQQJ4wXdwToEznpgLoeKZL1liQI=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To;
 b=btt+oP+sTzFmjKnOVrKP6m0/SVtZsyF4faFwGgTUtODZETb7E4WwW4LKN+yNkHoea
 Okkew+9aRzFUaaLDE+DY32dUW9jpJPwz7/u1aJzvC4/YYVm4fpkP2AS+uUkG8yYXSW
 h0zyfQuW5pTy6c7y/Rg6KCts2UKlkfFE9YFObabAMzefbgmB/yjUZKtGdukVpe0453
 PPg5IyX7reA6PSrdX+1uv+zK2fg9c+LjL76veIy40qSwshbqOJXeg3n5ll/biVtawP
 SPGxdk2EzlbE7DVb0vPfbmWdZ/EpX1iaLWTQShzq+leR+0QKJciChxgad3c/1DHWQc
 u9XnBpS54QTww==
Message-ID: <3fd23334-2b38-450a-b4de-bd2621b0e919@kernel.org>
Date: Tue, 17 Nov 2026 19:25:50 +0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Daeho Jeong <daeho43@gmail.com>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
References: <20261116040851.2849696-1-daeho43@gmail.com>
 <20261116040851.2849696-14-daeho43@gmail.com>
Content-Language: en-US
In-Reply-To: <20261116040851.2849696-14-daeho43@gmail.com>
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xTHK3-000000007fj-2adR
Subject: Re: [f2fs-dev] [PATCH v2 13/20] f2fs: support subpage blocks in
 swapfile activation
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
Cc: Daeho Jeong <daehojeong@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/16/26 12:08, Daeho Jeong wrote:
> From: Daeho Jeong <daehojeong@google.com>
> 
> The swap subsystem works in PAGE_SIZE units. Ignore a partial tail
> page, require PAGE_SIZE aligned extents, and convert block counts and
> addresses to pages for swap. When migrating blocks, mark only the
> migrated block, not its whole page, dirty in the folio state.
> 
> Signed-off-by: Daeho Jeong <daehojeong@google.com>
Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
