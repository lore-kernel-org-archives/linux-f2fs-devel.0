Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF86DC0219B
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 10 Feb 2025 18:30:55 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1thYYY-0005A5-UV;
	Mon, 10 Feb 2025 18:30:54 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <corbet@lwn.net>) id 1thYYX-00059x-EV
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 10 Feb 2025 18:30:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:MIME-Version:Message-ID:Date:
 References:In-Reply-To:Subject:Cc:To:From:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=vlbv0FSFlLbSmcwi0qSd9c4OoNOyoJGUgwl16y4Fj8k=; b=igFIYsQYjzSQfG2J0JtHsc4QV0
 HQ4Sjk9Fl2yH8z0RhQFSpLVd7wD3Z/UHK9rwJJYmG3cOj7TNGjvy2Bc4SKJiK9y/aJxa7Rzr8A9EI
 E3glfu4JHAJ/IxgkRrxeQjmGTvVhy5MdeyUZSWhuMXc9eIR8D0/OsJVZGC4CPrqAOASE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:MIME-Version:Message-ID:Date:References:In-Reply-To:Subject:
 Cc:To:From:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=vlbv0FSFlLbSmcwi0qSd9c4OoNOyoJGUgwl16y4Fj8k=; b=myzrRrmQfHoDLUJ4c0QV8CCjZF
 NcqMiTcNzBCtYJhpkhyH2VKdhQ6ftvC56SXPM1YKGYmk+g7J1yzurrKBZZffSp6/bsTFbKCG/n3ZC
 6V6ydpyejhpFBi1JMzFQvhZuQ/nLymigXF7zDQhq2J0TH82rDvLqtOo+F/0Lxm1RIuw0=;
Received: from ms.lwn.net ([45.79.88.28])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1thYYW-0001ki-O5 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 10 Feb 2025 18:30:53 +0000
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 0D1D5411A1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
 t=1739212247; bh=vlbv0FSFlLbSmcwi0qSd9c4OoNOyoJGUgwl16y4Fj8k=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=PxFnHkEKSZrBYbzFpew/UljRdQUkTOX+qKIpKomAZlWSWpxide9l4c2bxkwdMwNWF
 sWHrza4QeD17HbEJ1GVDgKEHsQ4J5fGszAooe0rUMV8SpHN2AnJh5s+msApTtSueTq
 kldvsJD8z29V82iGnnNsIvc0IpF/n5AUf1V7EwE15mOEBZuS5tkWNvoYAelEzc0LtF
 9A/zQoFU1JnwlyetVPR6L3frzztdtk0XDVlSCAuejySkEp8NEq0ylr0UsJ5g1a1OZE
 Vo03pIkLZ7JlMiGrr1nPdfsokPnHNxFSVgl0KcZB06VxFdKHkJg6ydIZAOvztgFrBm
 SzjyXR5yVqF2g==
Received: from localhost (unknown [IPv6:2601:280:5e00:625::1fe])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by ms.lwn.net (Postfix) with ESMTPSA id 0D1D5411A1;
 Mon, 10 Feb 2025 18:30:46 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, Linux Doc Mailing
 List <linux-doc@vger.kernel.org>
In-Reply-To: <cover.1739182025.git.mchehab+huawei@kernel.org>
References: <cover.1739182025.git.mchehab+huawei@kernel.org>
Date: Mon, 10 Feb 2025 11:30:46 -0700
Message-ID: <87h651zm7d.fsf@trenco.lwn.net>
MIME-Version: 1.0
X-Headers-End: 1thYYW-0001ki-O5
Subject: Re: [f2fs-dev] [PATCH 00/27] Improve ABI documentation generation
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
Cc: Tony Luck <tony.luck@intel.com>, Suzuki K Poulose <suzuki.poulose@arm.com>,
 Jaegeuk Kim <mchehab+huawei@kernel.org>, James Clark <james.clark@linaro.org>,
 linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, "Guilherme G.
 Piccoli" <gpiccoli@igalia.com>, linux-hardening@vger.kernel.org,
 coresight@lists.linaro.org, Johannes Berg <johannes@sipsolutions.net>,
 bpf@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Mike Leach <mike.leach@linaro.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Mauro Carvalho Chehab <mchehab+huawei@kernel.org> writes:

> Hi Jon/Greg,
>
> This series replace get_abi.pl with a Python version.
>
> I originally started it due to some issues I noticed when searching for
> ABI symbols. While I could just go ahead and fix the already existing
> script, I noticed that the script maintainance didn't have much care over
> all those years, probably because it is easier to find Python programmers
> those days.
>
> Also, the code is complex and was not using modules or classes and
> were using lots of global variables.
>
> So, I decided to rewrite it in Python. I started with a manual conversion
> for each function. Yet, to avoid future maintainership issues, I opted to
> divide the main code on three classes, each on a sepaparate file.
>
> Just like the original RFC, I opted to keep the Sphinx kernel-abi module
> on three different phases:
>
> - call get_abi.py as an exec file;
> - import AbiParser on a minimal integration scenario;
> - cleanup the code to avoid needing to parse line numbers from the text.
>
> This way, if something goes wrong, it would be easier to just revert any
> offending patches, It also provides a better rationale about what each
> logical change is doing.
>
> The initial patches on this series do some preparation work and
> cleans some ABI symbol bugs that lack ":" delimiter.
>
> I opted to place on this series the Sphinx and Python version updates.
>
> I still have ~10 patches here with additional cleanups, from the original
> series I sent as RFC but let's get the main changes merged first.

OK, I have applied this set - it seems to work for me, though it does
lead to some changes in the organization of
Documentation/admin-guide/abi.html in the output.

It would be nice if, eventually, we could put the README link up at the
top rather than under "ABI file", or even just include its contents
there directly.

Anyway, let's see how this goes :)

Thanks,

jon


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
