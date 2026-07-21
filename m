Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64BBFC4452D
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 21 Jul 2026 22:37:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5qkHNqYn4fNZS/d1jG3Lt9U/EYqWNZN0b1RTC86LSGQ=; b=MkET2hlQlLJ+GmQOfL431K4cr+
	5sq/6GxqbXpKQvsD2BZHZ983ya2+xGdw+3v8XcAlN0IS/02uOfYJm93rzf9Hz+RGsLEn4nrTqY7Vl
	yqkkizDtW5l53lMmFRnkqD0UubyvXP0fKWBBBTeazmwwIEtPt4Uvpq3DK/aZPdbgkdKE=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wmJ5C-0001xO-Gv;
	Tue, 21 Jul 2026 22:37:03 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <asj@kernel.org>) id 1wmJ5A-0001x8-Td
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 21 Jul 2026 22:37:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 References:Cc:To:Subject:From:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=NlNXfl9pPHGUuipgj86pe3+c/OOyL/s0HmQJZn9uCa8=; b=ENahHvrKlHep5VfYtpJjK+qe7+
 I5uEoziLEB8mYjqX62JUzU4AcVEFaUFUljWeKy45lho6vvm8GLE4+BAVmkmd68HkQg32OC4seKAdh
 gbskAT5qvCOSE6j98WeoFF9SXsw0CweNn8t+ZIbBIQ4mbpQFZhwXGux7+7rB8kNTe0jc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Cc:To:
 Subject:From:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=NlNXfl9pPHGUuipgj86pe3+c/OOyL/s0HmQJZn9uCa8=; b=lXhHu7J3HYhXhO3xUZs1wD/Hlw
 j2FbFoCTsF8QQC/G16yqhUHD0ONy1eRCwWhRCI08gltN6oa3SBVINN0GLCuSLsq/F9eWFn51ERzO8
 BLVhhuWeYB6ymUQhvjYjfYtmLhuVexfDc4sytg1lFFTsgx9aJKIpGLomvUaUrCU76ook=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wmJ5B-0003js-4Y for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 21 Jul 2026 22:37:01 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 3CCA460A77;
 Tue, 21 Jul 2026 22:36:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 368901F00A3D;
 Tue, 21 Jul 2026 22:36:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784673409;
 bh=NlNXfl9pPHGUuipgj86pe3+c/OOyL/s0HmQJZn9uCa8=;
 h=Date:From:Subject:To:Cc:References:In-Reply-To;
 b=HlMjBZdd0CFMwr3Juf0LblZKfANuFFKKmyJSbr99NSr1UKj7Dm1WBsfTava8rJo1B
 s30G4phlGrnbyD1USMggWxtinuCqZEmD7S13kTHqhT4M9JJBSZzmwqudWR74ZAUzzy
 NoX8NIVWzxorgtjuygClmL5lv5OzPDikN66Fucg6v+b7uSx8ToREc33AKjZwoKRZ3I
 /D1ORajl00iGPQHsgoMPjmJQP4P1646KgOFB3VfgFO1Ik995F6S1pCzqh3hmk3ERZ2
 NFzaR8/4RKESlpKJauAzuxXgmo2a3+UEQW5cYDd0JXdusP6PfDx27Kdu+AUpEIsyUB
 r9SBXlKAzMo2g==
Message-ID: <1fb99189-bd69-4618-bd20-f64205159b1b@kernel.org>
Date: Wed, 22 Jul 2026 06:36:47 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: "Darrick J. Wong" <djwong@kernel.org>, Anand Jain <asj@kernel.org>
References: <cover.1781694879.git.asj@kernel.org>
 <65f6e4b778e85bd16f16e7745eb985e2a70f44f7.1781694879.git.asj@kernel.org>
 <20260701171259.GG6517@frogsfrogsfrogs>
Content-Language: en-US
In-Reply-To: <20260701171259.GG6517@frogsfrogsfrogs>
X-Headers-End: 1wmJ5B-0003js-4Y
Subject: Re: [f2fs-dev] [PATCH v7 05/11] fstests: verify fanotify isolation
 on cloned filesystems
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
From: Anand Suveer Jain via Linux-f2fs-devel
 <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Anand Suveer Jain <asj@kernel.org>
Cc: hch@infradead.org, zlang@redhat.com, fstests@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org,
 linux-ext4@vger.kernel.org, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net


>> +. ./common/preamble
>> +
>> +_begin_fstest auto quick mount clone
>> +
>> +_require_test
>> +_require_block_device $TEST_DEV
>> +_require_loop
>> +_require_command "$FSNOTIFYWAIT_PROG" fsnotifywait
>> +_require_unique_f_fsid
>> +
>> +_cleanup()
>> +{
>> +	cd /
>> +	[[ -n $pid1 ]] && { kill -TERM "$pid1" 2> /dev/null; wait $pid1; }
>> +	[[ -n $pid2 ]] && { kill -TERM "$pid2" 2> /dev/null; wait $pid2; }
>> +
>> +	if [ "$semanage_added" = "yes" ]; then
>> +		semanage permissive -d unconfined_t >/dev/null 2>&1 || true
> 
> Needs to _require_command semanage, because it's not otherwise required
> by fstests.  Otherwise looks ok to me.
> 

Oh right. Added

In the new patch:
diff --git a/common/config b/common/config
::
+export SEMANAGE_PROG="$(type -P semanage)"


In this patch:
diff --git a/tests/generic/801 b/tests/generic/801
::
+_require_command "$SEMANAGE_PROG" semanage





_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
