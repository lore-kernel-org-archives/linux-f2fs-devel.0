Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1B38C61DD6
	for <linux-f2fs-devel@archiver.kernel.org>; Wed,  2 Sep 2026 14:40:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:References:
	Message-ID:To:Date:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4cnv9FpQJtT2nFrOrJ4e3tsf1dlJCMvIqtUkQRq9azE=; b=Lc3RNAAdM1sxnljSZsr+HYiTat
	9Ch5HUplLjVZMbkmHWOOx84+qizt69ugboVmAYjkMMa0mRHjXkVt7KSeqAib3w+wAeZEbDNAu3B1u
	aBHIHpxz0jsweHmMzlLzJUlV6mZ8mWQ9gglNUorwR8VS8Dv5py62DASgPzNaEk4P3VOs=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1x1m8C-0004sT-Lr;
	Wed, 02 Sep 2026 14:40:05 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <zlang@kernel.org>) id 1x1m8B-0004sM-EJ
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 02 Sep 2026 14:40:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Fr6k1WwqCxgN6aNYD5M2ttgQibMrSvNJsDUer6bgKX0=; b=Hiz/Sy0wbqt4Zx+WR7SHz/ebZI
 k+lWNatuXPlBbGMMJ2xHU5BEDPX397ilFLYXBpy0zV8pugscFKGtbo+w7VtNxjjpZERQavPvkI4gM
 2a/xv8o+jFudt6YY8rTsvJDb+JlwYpT57STc/2hHgChFYDrh5dd89VRO2gKoV2KaqAcM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=Fr6k1WwqCxgN6aNYD5M2ttgQibMrSvNJsDUer6bgKX0=; b=byocXi5mI3HCu5JRJdsnVjKgO8
 JqkzISYjyFShLWydIVkzrlokXslI7/q/Muwm3w06Sjq10k3g/crOzb3Qsvkf8JvS1I9QGDLrA+CGu
 pVUvPY2Uk+R+UpRS0cjKbAl54G9M+sInHV5QHJipiKscQ0jPLccN+DwoyL5VFAje3Xhg=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1x1m8B-000789-Ft for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 02 Sep 2026 14:40:04 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id D273F600D0;
 Wed,  2 Sep 2026 14:39:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCB8E1F000E9;
 Wed,  2 Sep 2026 14:39:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788359997;
 bh=Fr6k1WwqCxgN6aNYD5M2ttgQibMrSvNJsDUer6bgKX0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=kdpo2EJKpFczo+s56OGGup4zNuRu1hpQf36OqjJAXlLgP4qbslBYEPH8G8hpwgDq0
 +5TpTLHJITHZMYtUHfzZpJpzJSv4AbSV/jP3SMmjP/Kixv3FlQU7+KQjvfIL9D/6x3
 LSuukkdUtOgUR1OmyGEmk/q1VsMKB+IoP9sIymeuwNsYqVJC1qba7EYSXvn9BmYx4o
 nfUo7iin5d/ZVnMWnxcKEQzLFJUpH6j/aX4ieaPIUtotZ/Lj5HFNJXG6jZ2HQVu9WW
 Uu3il/FWbcbT7xZPQkBs3Is52liB6vPnqOi7TXj9Ic/71cOWhOY/842ZeCuqk4yRYO
 Br4L8fKgiUpSw==
Date: Wed, 2 Sep 2026 22:39:51 +0800
To: Prabhakar Pujeri <prabhakar.pujeri@dell.com>
Message-ID: <apg0duan2deLzcvv@zlang-mailbox>
Mail-Followup-To: Prabhakar Pujeri <prabhakar.pujeri@dell.com>, 
 fstests@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
References: <20260831104142.2229-1-prabhakar.pujeri@dell.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260831104142.2229-1-prabhakar.pujeri@dell.com>
X-Headers-End: 1x1m8B-000789-Ft
Subject: Re: [f2fs-dev] [PATCH] f2fs/024: add missing execute permission
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
From: Zorro Lang via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Zorro Lang <zlang@kernel.org>
Cc: fstests@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Mon, Aug 31, 2026 at 10:41:42AM +0000, Prabhakar Pujeri wrote:
> The test script was committed with mode 100644 while all other test
> scripts are 100755, so check fails to execute it directly with
> "Permission denied".  Fix the file mode.
> 
> Signed-off-by: Prabhakar Pujeri <prabhakar.pujeri@dell.com>
> ---

Fair enough, in hindsight I should have bundled this change when updating
f2fs/024 last time. Anyway, this fix looks fine to me as well.

Reviewed-by: Zorro Lang <zlang@kernel.org>

>  tests/f2fs/024 | 0
>  1 file changed, 0 insertions(+), 0 deletions(-)
>  mode change 100644 => 100755 tests/f2fs/024
> 
> diff --git a/tests/f2fs/024 b/tests/f2fs/024
> old mode 100644
> new mode 100755
> -- 
> 2.55.0
> 


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
