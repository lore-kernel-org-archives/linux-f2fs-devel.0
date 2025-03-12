Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDBF6C2BA1B
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 12 Mar 2025 03:34:48 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1tsCrn-000055-4W;
	Wed, 12 Mar 2025 03:34:47 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1tsCrl-00004w-P6
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 12 Mar 2025 03:34:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=w+nAexKW97mw9T6KXpXWqyM9NWNYhfJ5R9RBqDHuhHE=; b=SjLXyHr8tzpedtuBljDPPOdoTC
 4sU8Jt3ef8q8wL1MOiiT0cRo5tuphOQa32l6Kgnqaoz+BtLqbsjugjQQ3UvXr860wPGEXt6x8d/D1
 AYJf/cpTjfUdi6kVhaRETYGQlB2U3e2obHqlZFzDxrK0Fn2DKl0pbjoiVpicFTI2FZGk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=w+nAexKW97mw9T6KXpXWqyM9NWNYhfJ5R9RBqDHuhHE=; b=lvc2XOov3iHbEqDaNkaDjZc0aT
 djfYyCJi0fYJMXTyH4MVdruURZyw/T7MDlUk7L5DKGuF3AzszKNAIonRhbycWD7Kv08hCWEBwEU7V
 7oanK0jap+z9g1noo0nE8ejQS9YCUEeD7GeTn+mhT6Hh2Cp/2kxL9jze49ItMoiA5p0M=;
Received: from nyc.source.kernel.org ([147.75.193.91])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1tsCrg-0008DV-Us for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 12 Mar 2025 03:34:46 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id 3AFADA46CCE;
 Wed, 12 Mar 2025 03:29:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB1FCC4CEE3;
 Wed, 12 Mar 2025 03:34:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1741750469;
 bh=b45Z+D7ffeejcBx70Fuk9rfp2MnMcWD5LFUr7bsG690=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
 b=DZY4oJBCuJy+WCzh6D/d5m+BHfcAJwfv+TqQoE0fIkFHmhUFjQ2AnjcZr4Qqv5GYy
 kgAqA6z6y0GoAihUdot6oieHLOHyNUqZBLVQWXMIMTgzpDdIitWUvyQBvug5PQRdvg
 M1TsNYejRNqy4+m7W0El7PY/EAUHy8tZYo785u0nZrq94CZuYO7qfzOwes0o300ITp
 ryEgqBbX4x/0Ql66/ni1xZLWsIUrraYZLeUFElboxsE2F6Vn4Gg2ULiHRWywFYk1PW
 UeGoiYzy4MjwuEsXNTea9YyX72PgmGzb6dpC93HPyrd1Gb8iYZTTwoFUbOWAAs9Ucg
 eec2Qo14AvKvA==
Message-ID: <41b5f55f-bf27-443e-bea3-562797adf64c@kernel.org>
Date: Wed, 12 Mar 2025 11:34:26 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Eric Sandeen <sandeen@redhat.com>, linux-f2fs-devel@lists.sourceforge.net
References: <20250303172127.298602-1-sandeen@redhat.com>
 <20250303172127.298602-10-sandeen@redhat.com>
Content-Language: en-US
In-Reply-To: <20250303172127.298602-10-sandeen@redhat.com>
X-Headers-End: 1tsCrg-0008DV-Us
Subject: Re: [f2fs-dev] [PATCH 9/9] f2fs: pass sbi rather than sb to
 parse_options()
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
Cc: jaegeuk@kernel.org, lihongbo22@huawei.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 3/4/25 01:12, Eric Sandeen wrote:
> With the new mount API the sb will not be available during initial option
> parsing, which will happen before fill_super reads sb from disk.
> 
> Now that the sb is no longer directly referenced in parse_options, switch
> it to use sbi.
> 
> (Note that all calls to f2fs_sb_has_* originating from parse_options will
> need to be deferred to later before we can use the new mount API.)
> 
> Signed-off-by: Eric Sandeen <sandeen@redhat.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
