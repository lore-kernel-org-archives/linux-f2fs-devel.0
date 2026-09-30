Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CBB8CA5FB1
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 30 Sep 2026 08:10:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Content-Transfer-Encoding:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xhGEM8k6agTMDyaP1cXvikRN2DD9i8QXfnsKZO6hdxM=; b=Cte5GbbYcba2juVQMZDRRbLv5g
	U1zNXkqpmdL0ptPpVC4IRs5g8+IjmEf1eeF5aDve332g5K+9DJh25tOgJb9pvWaYHco6d0BwVoHV3
	ZTZzs0YlMv+g+/f+AEBW0KLB+uU1kgOu9+oYcG5xWBTqiq2OBIc+z5UQ4tPbN4+MzKh8=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xBpOx-0000zH-Uo;
	Wed, 30 Sep 2026 08:10:55 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1xBpOw-0000zA-LP
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 30 Sep 2026 08:10:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=jZbp4O7AEq6zBMXrMUVa/0pgZAfHinTr8WzmDWALHlQ=; b=eZlM7uXIYGyP7jyc6WlwWE/lzH
 3orqMgOiDfAbnfEyq4A4IDKxcg+AhySQlgj6/eyQqoeDY8N5l+DH7EhHQN98EltnBr4dby4loq+Gq
 cK7+qCpwkUTdpqeXBiihdo0Rdi25ctU2YIwFxTxd8SIS2jtJbVrXmKb0RvjI/Lj6JAzg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=jZbp4O7AEq6zBMXrMUVa/0pgZAfHinTr8WzmDWALHlQ=; b=Wqpsx3S0wRV5xl/7rgaGeYH0wL
 NuPxahUE7tZDRLZ6wBHzsSps4ph27RyvQqCbg7fBCZ/qcnYGjfvD5ns2yPq4qQAObUFyjePW80/pL
 /zzMwbqNnCcWCBpFJSaoNTeTt+qLarxdt1pcTsWTfafrGFAFS9/kIDGGQkSiuylh+GyU=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1xBpOu-00056U-0W for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 30 Sep 2026 08:10:54 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id AC669409F5;
 Wed, 30 Sep 2026 08:10:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 188AC1F000FF;
 Wed, 30 Sep 2026 08:10:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790755846;
 bh=jZbp4O7AEq6zBMXrMUVa/0pgZAfHinTr8WzmDWALHlQ=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To;
 b=T1yWPbUG3iO+OpaM28OQMX2lrKF/J6y5LfEooBGVEWjLX94L2dNBxIUt+j/kzt42C
 f5QBxfG2pzJpNlFUN3vJOEAuiXwKtABqLfnhf1BBd6/SGfYqtpOFaoj174QHSqKYnG
 DJMhGOCbLuB1eUyE2RaaRM5JiNGPSAUwdYpzJ6rDn63D+o/hQS7q+uLqDESWquL6Yu
 MXcCHBvQkfR9UF/X91InZnFTV55nLQD5K27gFDoufjl6DW2hlmG2S/IbpmMXHO7bDh
 nwjfdsWjqktoh8dugmG+sy5IBLJzizE8PmHDU9wArhaIBsDWm14pWh6xZGkLix6vIr
 rrhpeEwY11Z3g==
Message-ID: <989ede44-7d64-48b1-af9b-a0a45f824ab3@kernel.org>
Date: Wed, 30 Sep 2026 16:10:43 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Seongjae Jeong <jsjlee1020@gmail.com>, jaegeuk@kernel.org
References: <20260918133922.8163-1-jsjlee1020@gmail.com>
Content-Language: en-US
In-Reply-To: <20260918133922.8163-1-jsjlee1020@gmail.com>
X-Headers-End: 1xBpOu-00056U-0W
Subject: Re: [f2fs-dev] [PATCH] f2fs: reject device aliasing without a
 multi-device configuration
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
Cc: syzbot+ae5b8eb92ed40411ce16@syzkaller.appspotmail.com,
 linux-kernel@vger.kernel.org, daehojeong@google.com,
 linux-f2fs-devel@lists.sourceforge.net
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 9/18/26 21:39, Seongjae Jeong wrote:
> A malformed F2FS image can enable F2FS_FEATURE_DEVICE_ALIAS without
> providing a multi-device configuration. For a regular single-device
> filesystem, f2fs_scan_devices() returns without allocating sbi->devs.
> 
> In this state, f2fs_dev_is_alloc_blocked() passes the device alias
> feature check and dereferences FDEV(0), resulting in a NULL pointer
> dereference during segment allocation.
> 
> Device aliasing requires at least one secondary device. Reject
> superblocks that enable device aliasing without entries for both the
> main and secondary devices in sanity_check_raw_super().
> 
> Fixes: eae3faf210bd ("f2fs: support dynamic reserve/release for device aliasing")
> Reported-by: syzbot+ae5b8eb92ed40411ce16@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=ae5b8eb92ed40411ce16
> Signed-off-by: Seongjae Jeong <jsjlee1020@gmail.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
