Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FAE1C43458
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 10 Jul 2026 07:54:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Content-Transfer-Encoding:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=z/67k/qnTwLhShEh3aLvBWl1kQmAqd9m+ZULu8AmBWU=; b=bcLtPburTlbZJmUtc7QWHPZUs4
	XOfkKd2VemXpIK8QOZg2vbtSWl5YyYhqoMrebrs6Xra4OQPIIvHXUuJ+L6aQcRA4iQ/XEmksMXSEi
	cmgqk3yT0TeA36YjiEy9mOPXOLKXYaTd60xARrlqb/9Yw51lUVcb8xg75hbJ9+xAzMUk=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wi64D-00036C-L6;
	Fri, 10 Jul 2026 07:54:35 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1wi64A-000365-HA
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 10 Jul 2026 07:54:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=xXKsebu9VPI8L1iQz7JBKmKUmDVl0yRmjEOD3AeIJC0=; b=CVOfwHF/ARnObe1wNptcH5KIfK
 DxIlSwxVrKyMCy8D5E08NPfyo5ATiJ0W/C6dAnT5MYo1sYwZLdSpNyvKuGkDnPqVWEbq66peq46wL
 tcsl/SRElVLOHPogVcv7C2q1cc9Kh9MuFDjt0w1Z0aRPf6kGAUGIBkkKl6zGcG26SKtM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=xXKsebu9VPI8L1iQz7JBKmKUmDVl0yRmjEOD3AeIJC0=; b=U0TuMHpzTe/9S8Eoi0VxDtLf6B
 OmtEIjOvD5Lm2xw/wQPFDaCFf8isw2uwu/HyXlxtGBLvySJYOWeZR9VoeKPcWnYC1YCwuOUpeXCvS
 5tfEduImh2pj8iKYNbR5UUlP9AOVgYYnwBFi67abiSUS9hmDAoi08w5EiAcZjlxostMY=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wi646-0000Xi-Lq for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 10 Jul 2026 07:54:31 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 31847403CF;
 Fri, 10 Jul 2026 07:54:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CE731F000E9;
 Fri, 10 Jul 2026 07:54:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783670060;
 bh=xXKsebu9VPI8L1iQz7JBKmKUmDVl0yRmjEOD3AeIJC0=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To;
 b=JdrE6Gq0+0ndnCXe6oIwgBb85fRyOQauOUFxow6Fc+MdWEm0xkXP7EQwj/tj1Eb6S
 MO96jXmQOZbQdkpwPQGdRLjMPE/jZVgcblThjDE+WwqwYLHOApkG2XruUXxFEEpi5+
 zH172OP/FZA+Ed4Sx9ZDJVVJpQqpF+MBkUMLnhaX67jTznUFFJte82oT2fsuT/b6A1
 vfiHhTK4oT2F5hKp5QbyfQ0oXYHKi1UMPZxkdoUUJ79RrcKDO5KJ5VfMndm/TXXmg7
 kwRk1wuV6ByjBbCdCopks9HGt+E79+rMGUD47iDpWE5LkfxTgNTiSPY8JWpXXxFgGU
 QtRjmsBLvnhkQ==
Message-ID: <d10a038b-0ee4-485d-8e85-c7549ca7f96f@kernel.org>
Date: Fri, 10 Jul 2026 15:54:15 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Nanzhe Zhao <zhaonanzhe@xiaomi.com>
References: <64ce7a28-992d-4d20-bbb1-b76943911ab4@kernel.org>
 <20260710011534.2307696-3-zhaonanzhe@xiaomi.com>
 <f1ad5d3d-f4c5-498f-8378-a5efff74a458@kernel.org>
 <20260710074455.704198-1-zhaonanzhe@xiaomi.com>
Content-Language: en-US
In-Reply-To: <20260710074455.704198-1-zhaonanzhe@xiaomi.com>
X-Headers-End: 1wi646-0000Xi-Lq
Subject: Re: [f2fs-dev] [RFC PATCH 3/9] f2fs: support regular file buffered
 writes on large folios
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
 Dev Jain <Dev.Jain@arm.com>, David Hildenbrand <David.Hildenbrand@arm.com>,
 linux-f2fs-devel@lists.sourceforge.net, Bo Zhang <zhangbo56@xiaomi.com>,
 Kalesh Singh <kaleshsingh@google.com>, Ryan Roberts <Ryan.Roberts@arm.com>,
 Jaegeuk Kim <jaegeuk@kernel.org>, Pengfei Li <lipengfei28@xiaomi.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 7/10/26 15:44, Nanzhe Zhao wrote:
>>> Both the error path and the normal path will eventually reach the out label path,
>>> and out will call f2fs_put_dnode(&dn) if get_dn is true.
>>> Or am I missing something?
>>
>> For above case: both head and tail has partial updated data, then we call
>> f2fs_get_dnode_of_data() twice, but call f2fs_put_dnode() once?
> 
> I think f2fs_put_dnode() will be called twice in that case.
> 
> The out label is still inside the while loop body. For each block returned by

It's not in 3/9 at least:

+	}
+
+out:
+		if (get_dn)
+			f2fs_put_dnode(&dn);
+
+		return err;
+}

> f2fs_find_next_need_read_block(), get_dn is reset to false first. If
> f2fs_get_dnode_of_data() succeeds, get_dn is set to true, and the same
> iteration will fall through/goto out and call f2fs_put_dnode(&dn).
> 
> So for head and tail, the flow should be:
> 
> head: get dnode -> read/zero -> out -> put dnode
> tail: get dnode -> read/zero -> out -> put dnode
> 
> If head and tail are the same block, the first iteration marks it uptodate,
> so the next f2fs_find_next_need_read_block() will not return it again.
> 
> Hmmm, if the current control flow is so easy to misread, would you like me
> to change it a bit to make the per-iteration dnode lifetime more obvious?
> 
> Thanks,
> 



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
