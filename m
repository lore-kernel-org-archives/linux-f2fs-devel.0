Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB3B4606A31C
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 11 Nov 2026 13:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=DKqbL5p+;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=GTI59hyZ;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=MaG9CJLH;
	dkim=neutral header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=kXLJT622
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:To:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:List-Owner;
	bh=rLQ23SYgpTrz72cKgqETT9XkH5+OfZS333VPjD0T7lA=; b=DKqbL5p+ZjtzHLudwHIvSqfuaj
	Ii9HmI5epZrVfboNutnXh0e4rfoarLp3qxRlJRoU5eO0iYdrezS5NsthRSzJHV7PSyeAyVOoVYmxM
	zXGrkLgPGW2RwUhXm7MMKjAAV18gUUCoUtoNbdIQSoCIqGYE60K4Ngnx/E6k+N6RxjTI=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xR8aU-000000003Ct-3CmK;
	Wed, 11 Nov 2026 13:42:06 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <dennylin0707@gmail.com>) id 1xR8aT-000000003Cm-1pSp
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 11 Nov 2026 13:42:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Cc:To:Subject:Message-ID:Date:From:
 In-Reply-To:References:MIME-Version:Sender:Reply-To:Content-Transfer-Encoding
 :Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=DXnOrYJndBjtvfOZAozL2l4Cp0d2hZXtDRZnAOOlgK4=; b=GTI59hyZM827puz4t5bBrK7EHx
 Q95/IktF3+f693PRwYQFSgcNk95yQS2VW9BR3jVfl4h/GjI9GMemarpbWmM7ZgT+IWztFCdxhvhqk
 20D4xP6IW1NY/8jAeLL853Y2s0oUBm4qaysFoOBPaNM4vkxTe6dylGCiKJYWVm6XsXYQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
 MIME-Version:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=DXnOrYJndBjtvfOZAozL2l4Cp0d2hZXtDRZnAOOlgK4=; b=MaG9CJLHRn9Ri+gAo58aSsgeHl
 CGFUqIZ9vwTRJQu8dCEVPHl8XynNDizQEfmO4QMtYdiPkkMRPxq/9a7CP5ufUBH4wjwXVNRdY7BN9
 PuBzCyst5ky96dzYI1MQZbv0Oaw8MDXE1C9AfDZCstHKPunInFQUjvkK+oc8caKG6B5A=;
Received: from mail-oi2-f0.google.com ([74.125.231.192])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xR8aR-000000006of-3mvJ
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 11 Nov 2026 13:42:05 +0000
Received: by mail-oi2-f0.google.com with SMTP id
 5614622812f47-533fe730856so1367520b6e.1
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed, 11 Nov 2026 05:42:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794404518; cv=none;
 d=google.com; s=arc-20260327;
 b=omiYfPeny8vv/qpRtfMcEeqdZaXFxji+YJDzjlHkQPdwHdWayhCxFxCpqY5K46xn5/
 CxEXokKAKKcUTantGDUX7gTTaHUe/dicx/vQpmbYNzE2rQLLkLQj6x+HVmh7mmfFBfhI
 0ML14wXaA650MvfzCjvYoVsUXOL5OQHs3nMxM0dJ605P9JB/SF35Cv5Neg/cYvWukQym
 RKRb/8SgPuR1lLKtWEOeXYi7crg8CYgXCLN8JLtsRo0oXYjV0LwdZeRbD+ttTvbRnmrN
 mWOlaKRYfJ+keDJWtZFq2QjG064UF0K7IcHbpUwRotk8/z4RN4FHDNEjfAhcGa7pEK3F
 ziBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=DXnOrYJndBjtvfOZAozL2l4Cp0d2hZXtDRZnAOOlgK4=;
 fh=45qVXSHYX50Tl9WFbOijFR4A+/RSX8vSQNQr5KN5APY=;
 b=QhM/9/j816op1VzLln60bkKPPjqsmctpfsgkOQXeRrynJFrEEbromBwZvwe7BuIKY4
 kBwZbuNLD37xmPoMRK62yetBO/BD2gDpwmuY+h4XUPCDHP+UjjQldjU+/9dcMCiSBjYu
 DGAz+9CQP6+HOwjdrcShJkMyWzKPxaGwDvxfVq6NrhohpSo2qEorGCSNt5g4XhCXsigH
 dXRlJMkmNlb/DbscaCA14mVaCKjfhTB8NaFl6Z9kcxO7XqwIKu0bbfVKAlTE8lTUS/iv
 vg7N7jnZXpu6zGrgrxo5QP7LrVHq49VUE31OgkATeffcwiImfqL0LV3hl9vxgZgbu11k
 RgDA==; darn=lists.sourceforge.net
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794404518; x=1795009318; darn=lists.sourceforge.net;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=DXnOrYJndBjtvfOZAozL2l4Cp0d2hZXtDRZnAOOlgK4=;
 b=kXLJT622XH4fSPKYiqNzHhNWbj30aL4JXEjAumnIt2x1IzlkXJOJWYRncN+PZER361
 xL2ynswPUuYK+PonVsVhO2Y0AabpZAFG46znOCBZHuyILRZvNvRf2j+iX8htfbMhWo/z
 XZRLGQPDE+cR4r2DnYxgb6bzzSjrDhkIh3x5jHSsX9Dgy9SQmuuuCqjUdW5ZK/3IRfdD
 zRrQRZ3fQiDVYruNBiKB+EY77bhIkjjNG6NELJY4JtENn6ImEhzs2gR+bb644DcsWFUa
 Bo5ud3M1Yn0ocKHojgJFsmjxaLSmngvw+6Nka3GYjjF2g2BqOj05i8Oz6ZQY/ACZhqQM
 N9QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794404518; x=1795009318;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=DXnOrYJndBjtvfOZAozL2l4Cp0d2hZXtDRZnAOOlgK4=;
 b=LqW75w2s1fuc5evwpRHCNawWEE0KRbyc5qRIq0/ODLVuZng1JK7MdLruZWiHLfdv10
 //X58ZnnzrV8rsELt3FAd+tDcF+oRfUVNnbsN+tdjExwVxAHOVCTTEWHwTwGfHZni9Dq
 fQYp6FuSEFdGqGHxlXrz6Qf2GvuSJSEbmJQJ/wUBFQUdDYjKwVP4/v3xbAabbOIJOUqi
 6RJpMIyOZGAqDu8konYcAb6VtMqPEa+4CpjXAqq7XV3keaKLo99Vk2dLw2PQAnzuRnyU
 6elXbts1Tzo3acL9Xins4DTR/LurW35JgTPBKmIeUNTgS8QIMQAFhdwTcTHtbPzBd+MO
 dOuw==
X-Forwarded-Encrypted: i=1;
 AL+hErEIEbDezmnrwt5bdaQuDW3l87asRrJ/kkPLlG7mWVBF/ZTV4ZNjbfT5a7PLY0i06Nj1j0hPkq+ajAIH8WH7Kx85@lists.sourceforge.net
X-Gm-Message-State: APuU4Z81S0f5LdBdkcxPTlIpLPKJVQqCecKkB97fYTbx9t6QmmZi+Kol
 qTg/zwIrXHcCFK13Dnc2LyRVkBc/CXMbASODkXc9fGMi1NA7n4W9AOx+wo+XUL27n6K0e01NJPX
 75uwzPe1qs05aKYlO3bE6K0pPxoNDcTU=
X-Gm-Gg: AYBFou2M5HRWEujhc2XIUla6rRwLuvkNsDbONaBuSJRP4IMuyv8qAjoOAoGl8DtTVKb
 51xpredDHP7CAnf3R8n08clcWU9OaOLTA9TkrAhCa2ZpPQi+1T4kmqnswEnVq0G9zGnAmLa95Ic
 22CLD8DwYV7LdGg4PHobJ1qTuFH22MPSP1z7T0LwE1Bm8aYIdxXm+1FjnGQZ569gDXM4eLzeKFj
 iVUyuDnqrFbBUqExvrUGQLEuVHIW/9NYRZ4YETx1iTjwXFSPoLGEu2V8oia11P9aRfsMbTaDIId
 VHQ2mk1rhoTM66IVIeuepL6I6qVISgIyKbPXqXp64XOgdArTwXg8WcFYGQ+LNR7E81ZPjHh//Vu
 lgFIyCLlBoC5XuZJNKh4BqZSXa8i56mb5EjrtEWMCoHdY+OdGmUYXmZT6q0i99cu7jRDkQFAasS
 X+LB5dCCfBX3Q3xWbMzYjm6qkMymhGQ9zL0mN/is/jyhVFmo6lw7/ZjgHp/hA8r1m1u3sNjYn01
 A==
X-Received: by 2002:a05:6808:10cd:b0:55b:f88d:6ebd with SMTP id
 5614622812f47-56b9293c5f0mr1861940b6e.3.1794404518140; Wed, 11 Nov 2026
 05:41:58 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261104191621.89561-1-dennylin0707@gmail.com>
In-Reply-To: <20261104191621.89561-1-dennylin0707@gmail.com>
From: Hungyu Lin <dennylin0707@gmail.com>
Date: Wed, 11 Nov 2026 05:41:47 -0800
X-Gm-Features: AclHuK979fFPsKcuUOg3hUc17dq81L1BTuEdNVZioITPsDqDO4LERCg-x-Z03Ik
Message-ID: <CAGEkeHeMnYs_SM610dCCBPufJHAN6t00WBtC6YtgyZbw_GfUcA@mail.gmail.com>
To: jaegeuk@kernel.org, chao@kernel.org
X-Spam-Score: 0.1 (/)
X-Headers-End: 1xR8aR-000000006of-3mvJ
Subject: Re: [f2fs-dev] [PATCH] f2fs: read atomic replacements through the
 COW inode
X-BeenThere: linux-f2fs-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: linux-kernel@vger.kernel.org, daehojeong@google.com, stable@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.9 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Chao,

Gentle ping on this.

Thanks,
Hungyu


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
