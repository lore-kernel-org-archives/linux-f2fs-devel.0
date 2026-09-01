Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC158C624D4
	for <linux-f2fs-devel@archiver.kernel.org>; Tue,  1 Sep 2026 13:54:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=yrMAEStcO85ItY9gjyD2Mc4QAtyqayiVkhQ9zKgNFY4=; b=ZgGj7lSDVmLhAbdqX0fb15v351
	07Efa4f/DV6tF/mjejatRgKZRvTEu6yigA9Xa8pjGITcS+1JW+8QSDDmFhBNCbJBM30f2C2dKuV2R
	GbMGzZhUscQzihbwL719XNqelF0wb0kkOPiGCHtFrMEpOYWCAmdM/yYh0oC/aWzXwb4E=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1x1OwM-0006p5-G3;
	Tue, 01 Sep 2026 13:54:16 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <asj@kernel.org>) id 1x1OwL-0006ox-Fv
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 01 Sep 2026 13:54:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:Cc:References:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=FSggidhwF8rabJWJx6KgPECdT7Asd7yKc81seawfoQI=; b=fSKdewkfg420zAY2WksVnTRN2A
 v/8/soyb43N/kWOyGiD0S4ldp9E4StAyDJVYrHZlFflrHrAxjFpqeOUs5vJrt8rrOBOFTOnkNjjVl
 HRUM7+Yb7qlitkUyYWMbipq9gldC7bOL/W40iDJ9GwzRIirgeiCBNP+vFwZOgf0FcK28=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:Cc:References:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=FSggidhwF8rabJWJx6KgPECdT7Asd7yKc81seawfoQI=; b=fCv3qIeC8v+BHTeg43Wy9Cv2uE
 1tUOE6h5JXz5wLsNZ7zhku2FwvvRjDIfVU4FO+gEVPPOtUz1lfx21FaWzeOtteAJjJH8xJiCRmlEn
 WC6Mp4uIky+/ZeJnINg161KNTRrQ+V0wahTOsaRErOWeduXvUQSUrulu7NQsdWBKd0zo=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1x1OwI-0002YH-Ja for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 01 Sep 2026 13:54:14 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 40D1B4084D
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue,  1 Sep 2026 13:54:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AE2C1F000E9;
 Tue,  1 Sep 2026 13:54:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788270849;
 bh=FSggidhwF8rabJWJx6KgPECdT7Asd7yKc81seawfoQI=;
 h=Date:Subject:To:References:Cc:From:In-Reply-To;
 b=dSWYiDl7IbPcUEvGBoMjKlvTjNsW36AK3bd+s7SD4w9X+eXU86uBR2/5xjBvkQGTv
 wr1TxFSn3WL8+mO9kUYaC5Yaq2eqCVTm4TcHBNW4x0fKJiXKI0F58/gzO2FxJgBJPc
 DbcaYU56S5l1I40Qskx0Aa0/gBOMqy4Xs3HjT94vDPmM0WceLX/PQdb5+N3iOvRVzj
 3/kQb5guEuVsyE6aZhZjDJCY/xvdXluaOFwIyF5hXTg4QBIeab6ENaGUyaEVe5fBBf
 xzVia6FiGjNyzQtPFkUzENxwnLEqAiH/Vs4FfaqbLzBDj2VkXyC/cUxPQ2Zi45rusL
 wauXay7WULYOw==
Message-ID: <4226c2b6-d108-4666-9ac9-b52830b3fd50@kernel.org>
Date: Tue, 1 Sep 2026 21:54:05 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Zorro Lang <zlang@kernel.org>
References: <cover.1784949154.git.asj@kernel.org>
 <75ceae4b427ab53c921af395854794b78d7e07a9.1784949154.git.asj@kernel.org>
 <apbGwZODzZIvOyi0@zlang-mailbox>
Content-Language: en-US
In-Reply-To: <apbGwZODzZIvOyi0@zlang-mailbox>
X-Headers-End: 1x1OwI-0002YH-Ja
Subject: Re: [f2fs-dev] [PATCH v8 02/13] fstests: add _clone_mount_option()
 helper
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
Cc: djwong@kernel.org, fstests@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org,
 linux-ext4@vger.kernel.org, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 1/9/26 20:39, Zorro Lang wrote:
> On Sat, Jul 25, 2026 at 03:38:59PM +0800, Anand Jain wrote:
>> Adds _clone_mount_option() helper function to handle filesystem-specific
>> requirements for mounting cloned devices. Abstract the need for -o nouuid
>> on XFS.
>>
>> Signed-off-by: Anand Jain <asj@kernel.org>
>> Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
>> ---
>>  common/rc | 13 +++++++++++++
>>  1 file changed, 13 insertions(+)
>>
>> diff --git a/common/rc b/common/rc
>> index e8ff5be0c547..53e5d9d43af6 100644
>> --- a/common/rc
>> +++ b/common/rc
>> @@ -414,6 +414,19 @@ _scratch_mount_options()
>>  					$SCRATCH_DEV $SCRATCH_MNT
>>  }
>>  
>> +# Return filesystem-specific mount options required for mounting clone/snapshot
>> +# devices.
>> +_clone_mount_option()
> 
> Just a minor nitpick :) For consistency with other *_mount_options functions
> (in common/rc), I suggest using "options" instead of "option" -- _clone_mount_options
> 

I'm okay with that, though this rename will impact the rest of the patch
series too.

Thanks, Anand


>> +{
>> +	case "$FSTYP" in
>> +	xfs)
>> +		# Allow mounting a duplicate filesystem on the same host
>> +		echo "-o nouuid"
>> +		;;
>> +	*)
>> +	esac
>> +}
>> +
>>  _supports_filetype()
>>  {
>>  	local dir=$1
>> -- 
>> 2.43.0
>>



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
