Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27F38C79F9E
	for <linux-f2fs-devel@archiver.kernel.org>; Mon,  7 Sep 2026 02:20:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Content-Transfer-Encoding:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8pkC9+koP4p6bC3gwCWQuGxMzOn8lb9tY7egDubdIuE=; b=cyiHoYQXZe9or6WBdg3Kc/yWo5
	+wvmhxOKCNPt+u+gMBYcjYwXEVXnAo8XEuSxoVvokO+lRITdf7sx9vyBp0yXd8CscxE6jbk3UOM43
	cSdsgkbjrGSO2BBaBXZHE2hgtq0QKZJtQWMVIQxJrsneY22q+QLBBSL8I5aHAuOlV+Fc=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1x3OyR-0007uK-LL;
	Mon, 07 Sep 2026 02:20:43 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1x3OyQ-0007uE-LJ
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 07 Sep 2026 02:20:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=7J98PMeNTJ9iq9dARIKAaoUELhEmaK5KBEp2RtaApuc=; b=hC9lIoxBO2fjYcfg1ukHCan78A
 lKMAdmA020YYILBeO3eGhrbYp+kojfr7JpETbORKhtF4LHBkxwn3Yj5T24+zMplmN0kb+z7WFmjDu
 rMwGW8I6YZz6uXcfljfGBTLnaJMsk+N3qvbgD/cLjblCqnUIRrSXeASgN8fWYV5AZ9xM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=7J98PMeNTJ9iq9dARIKAaoUELhEmaK5KBEp2RtaApuc=; b=UOmGjmit8U5UJxkMmxwXG2UC6f
 fycLMKi+uG/WswDYY0XlbWP9PW7kJjrOofJtgo4NO+/pes1j8JjYnVfVbm1R2FbA2d1A0ME9pG3YK
 vEYGZoRROpvrS7dKNWmtwT/CqaY48CjBf3rzSZmU+Zta+UguOl6oza5a8pHj4tVU7aGg=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1x3OyQ-0005jS-5N for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 07 Sep 2026 02:20:42 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id BBAE643ECB;
 Mon,  7 Sep 2026 02:20:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 190491F00A3A;
 Mon,  7 Sep 2026 02:20:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788747636;
 bh=7J98PMeNTJ9iq9dARIKAaoUELhEmaK5KBEp2RtaApuc=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To;
 b=AnEunOFYnG8NKHCIxvyuCqEhLMggaMMvcla7zItERhLO4FPNzz2EuApK3MNd9mF/H
 tPbt44aChCcpTu3Te74a8rbhR+BVK9X8vBqn8lHfL7YLcR3zt60hE/k7eehI4f6ZF0
 BQJxZC64HyOWHAxkHV0egejx4Z2zQJx8yMR1Ah1H0av/NTh8oiPu1+SwSIGExvAguV
 gAvOZP7GiUpc6BSn9jeUuvrwZ05mtPgsk1/lfbPXOVwJKRxvp9Iv9sTYCKYjtBRgUH
 VTVU2Frpm/bvLM4Kx3TMj0NeAHbr94f8UKpo9VApm1dNaw8Mk4yNl34soQAVFYhLyf
 biOIqDUQfhFbA==
Message-ID: <d2e1b8bd-f575-4f83-a64e-2afef5f1ce2c@kernel.org>
Date: Mon, 7 Sep 2026 02:20:33 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Daeho Jeong <daeho43@gmail.com>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
References: <20260826181121.3825702-1-daeho43@gmail.com>
Content-Language: en-US
In-Reply-To: <20260826181121.3825702-1-daeho43@gmail.com>
X-Headers-End: 1x3OyQ-0005jS-5N
Subject: Re: [f2fs-dev] [PATCH] mkfs.f2fs: enforce alias_filename to match
 device name
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
Cc: Daeho Jeong <daehojeong@google.com>, stable@vger.kernel.org,
 Wenjie Qi <qiwenjie@xiaomi.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 8/26/26 18:11, Daeho Jeong wrote:
> From: Daeho Jeong <daehojeong@google.com>
> 
> The kernel expects the device alias file in the root directory to match
> the device basename (strrchr(path, '/') + 1) to identify the target device
> both during mount in f2fs_restore_device_alias() and during reserve in
> f2fs_ioc_reserve_dev_alias().
> 
> If a custom alias filename that differs from the device name is used,
> the kernel fails to match the alias file at mount time (leaving
> FDEV(i).has_alias unset and allowing pinned files to allocate in that
> range) and subsequently fails to reserve the device range when requested.
> 
> Enforce that if an alias filename is specified, it must match the device
> name. Also allow specifying just '-c <device>@' as a shorthand so users
> do not have to redundantly type the device basename twice.

Do we need to add a sanity check in kernel side as well, show warning info
if device name doesn't match device alias file name?

> 
> Reported-by: Wenjie Qi <qiwenjie@xiaomi.com>
> Fixes: 8cc4e257ec20 ("mkfs.f2fs: add device aliasing feature")
> Cc: stable@vger.kernel.org
> Signed-off-by: Daeho Jeong <daehojeong@google.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
