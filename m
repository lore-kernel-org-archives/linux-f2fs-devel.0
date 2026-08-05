Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E09D2C55184
	for <linux-f2fs-devel@archiver.kernel.org>; Wed,  5 Aug 2026 01:21:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=egmvK/AvD9q+LLtBFc3zwAqDse2mRbo0KEtky7/uSMI=; b=bmuRyUw0Ym5lK1idQ+iWmrCGpM
	drQUddd43zNMcD6N5A9sLk1iG2u98XxRb4SAtzpK0pacXyLa0TptoSBXh7Nq/lduywtkQCkFVip7W
	gdp/LXPV2vfzdo+CWfK05MsAV0O9C4xIttQ8uH64vfOTMryuFT3yJqUmPjS3URtF9fbk=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wrQKT-0005ki-KM;
	Wed, 05 Aug 2026 01:21:58 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1wrQKS-0005kb-Ie
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 05 Aug 2026 01:21:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=3Zh/UIvVuYNV5Caa0rgiPiBgHeVOh9x1UVDC5P4FZ4U=; b=OT8F0LJvGBua9xSv+SuisRvhUX
 l+2hrB6GDgzgVWrBjx/tNhkBXCnQjzd9Cf4uT4s0zXr1ukabJh4A1k5GVd8V2yOXhoY0Py+lfYtWF
 I8ZlbCU/XFbkvRhs+hmW6Rtdq68rxobznY7c/INgrqY9edgabgrTu0EAS+7y0ApAPgdQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=3Zh/UIvVuYNV5Caa0rgiPiBgHeVOh9x1UVDC5P4FZ4U=; b=eSCJWLGpR70ii/ediFbZTE7q3N
 qZKHNyb8DKsj+CxKWyZ/LD4rEJ3xlae3djFgfnqDAvhjOzV5Wxquupu/Jo9+TVUY0ijXn+f1+epwB
 TruY2LVpZB6ApuvgIS5E/u5mF2zchJhL5eev/cV4aU8gsr3aetJ8ZenupbwxLW4at3js=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wrQKS-0007vH-Ps for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 05 Aug 2026 01:21:57 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 2C5F8600AA;
 Wed,  5 Aug 2026 01:21:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF1A11F000E9;
 Wed,  5 Aug 2026 01:21:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785892910;
 bh=3Zh/UIvVuYNV5Caa0rgiPiBgHeVOh9x1UVDC5P4FZ4U=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To;
 b=h59CSk32+EojnihjpYX/e6qOv+hMYIJ/hm1YpBh2TrxETQ1f3AWe9aXE5xNIF6HyU
 rXkf86GvIkn/JdI9PAAoNzXoEwtSMsLipv6sYdz07Cfe/09HNZA0TsplaqHwp1hNgq
 CFWjU1fe24JYnaGXX/+dXh/zaWXW7RyD892lnWIMfuvCfOLsllnEW5j3t+OhImJWLl
 QzbF1mzZ8oT67p8xoJJ9u5NTKqywFrbRmy6weWwQHYZM85osdR4cv2cPGp8WAFmuhO
 PMyR8o+HidT34Tmw5dQ52WxBgZqs6WhDisUSvYYtSYsL3cylfuk02ITtsIeAITIF0z
 x5Z1he4vJkIxw==
Message-ID: <9ac3e5ff-9b8f-407d-9ed1-18cb3c23c040@kernel.org>
Date: Wed, 5 Aug 2026 09:21:47 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Daeho Jeong <daeho43@gmail.com>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
References: <20260804171804.28860-1-daeho43@gmail.com>
Content-Language: en-US
In-Reply-To: <20260804171804.28860-1-daeho43@gmail.com>
X-Headers-End: 1wrQKS-0007vH-Ps
Subject: Re: [f2fs-dev] [PATCH v3] fsck.f2fs: sanitize invalid segment type
 during block update
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
Cc: Daeho Jeong <daehojeong@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 8/5/26 01:18, Daeho Jeong wrote:
> From: Daeho Jeong <daehojeong@google.com>
> 
> If an invalid segment type (type < 0 || type >= NO_CHECK_TYPE) is read
> from SIT during block update, update_block() now validates the type,
> reports corruption via ASSERT_MSG(), fixes se->type directly, and falls
> back to a valid active curseg type based on its SSA summary block type
> when fix_on is enabled. find_next_free_block() also validates want_type to
> prevent out-of-bounds accesses.
> 
> Signed-off-by: Daeho Jeong <daehojeong@google.com>
Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
