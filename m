Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 657DDC4345F
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 16 Apr 2024 10:20:16 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1rwfvD-0004Ec-If;
	Tue, 16 Apr 2024 10:20:15 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1rwfvB-0004ER-8O
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 16 Apr 2024 10:20:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=OFCNfRsq9gGpKP5T9h/GHxaSvOPCz7xwV9sJYcdEESA=; b=EdQw/H6cU8VQdhD9lkcOAEKd70
 Izfwvbwg7ogWbCamN4yc7Wk9hTlgEopRZvVKRjthGcHw0F9vySUWHa17aU1CEbrc5WZ4SgKvBpfQK
 HPy7zihwpVihWANOlNhdLJ/j1HwvePY/aORsquLdlOu2oxA58NPEy+tNCUqnCyo8QMus=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=OFCNfRsq9gGpKP5T9h/GHxaSvOPCz7xwV9sJYcdEESA=; b=hX/btk7vJXB0cFyVks9guIbzeK
 cbg73lvZ0sl+DTotKEXjReVUrV8SqZM9AVpOW35nivNAsZkL+tEK5Rzqlu69ky0YEwhCknItPyYL+
 6+Ye2iYIWs5C29lJAGX5V3206J5M5tMYTFvIJKFXG/ez2QIo1Sj2FFPQGaLco/mQ1BUQ=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1rwfvA-0001re-33 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 16 Apr 2024 10:20:13 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 925AC61074;
 Tue, 16 Apr 2024 10:20:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E91EAC113CE;
 Tue, 16 Apr 2024 10:19:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1713262801;
 bh=F4FjHqN87UmanSyv65jjL7IOLPyOXqO0G1rKrueATwg=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=JWfZ2HnCubyCMX64qleVofUf7ZROwCSdMDZOEDf9jCXg7uZ5tyrs5dyM07LYhV0FK
 T2zo5/aIAoVSzjDGaIrVAS1D5vjE40tcLdYStB6046w75nidqrxvJOTjRbrspjuf3a
 TkfZU/Qj4PPXecHgFWCyszrKZb4eThZ9gmo1FJbHzUooW8kGrue8HZ82kmw9UAw34d
 mZOj8WQtsWLfL2T58BPAmyUkVKD9xJsmRk4bqxXWkNMkOWBIHSyAEANXQWsjQIeEGm
 e70UNfSOPOHBFAeTwMs9o+VvsryvPlvGtLvCZHYV4/pO0lqAAHK5+i+0jxu7jqesOC
 5B3u0QqSRYJ/A==
Message-ID: <1e6763f8-de07-4fc4-8d9d-ca948d66fdbc@kernel.org>
Date: Tue, 16 Apr 2024 18:19:57 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Zorro Lang <zlang@redhat.com>
References: <20240416071819.5004-1-chao@kernel.org>
 <20240416084957.gyavejnhja6mofvo@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20240416084957.gyavejnhja6mofvo@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
X-Headers-End: 1rwfvA-0001re-33
Subject: Re: [f2fs-dev] [PATCH] common/quota: fix keywords of quota feature
 in _require_prjquota() for f2fs
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
Cc: Jaegeuk Kim <jaegeuk@kernel.org>, fstests@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2024/4/16 16:49, Zorro Lang wrote:
> On Tue, Apr 16, 2024 at 03:18:19PM +0800, Chao Yu wrote:
>> Previously, in f2fs, sysfile quota feature has different name:
>> - "quota" in mkfs.f2fs
>> - and "quota_ino" in dump.f2fs
>>
>> Now, it has unified the name to "quota" since commit 92cc5edeb7
>> ("f2fs-tools: reuse feature_table to clean up print_sb_state()").
>>
>> It needs to fix keywords in _require_prjquota() for f2fs, Otherwise,
>> quota testcase will fail.
>>
>> generic/383 1s ... [not run] quota sysfile not enabled in this device /dev/vdc
>>
>> Cc: Jaegeuk Kim <jaegeuk@kernel.org>
>> Signed-off-by: Chao Yu <chao@kernel.org>
>> ---
>>   common/quota | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/common/quota b/common/quota
>> index 6b529bf4..cfe3276f 100644
>> --- a/common/quota
>> +++ b/common/quota
>> @@ -145,7 +145,7 @@ _require_prjquota()
>>       if [ "$FSTYP" == "f2fs" ]; then
>>   	dump.f2fs $_dev 2>&1 | grep -qw project_quota
>>   	[ $? -ne 0 ] && _notrun "Project quota not enabled in this device $_dev"
>> -	dump.f2fs $_dev 2>&1 | grep -qw quota_ino
>> +	dump.f2fs $_dev 2>&1 | grep -qw quota
> 
> This will _notrun on old f2fs-tools, due to `grep -w quota` doesn't match
> old "quota_ino". So how about grep -Eqw "quota|quota_ino", or any better idea
> you have.

Thanks for your suggestion, I fix this in v2, I've tested v2 w/ old f2fs-tools,
it works fine.

Thanks,

> 
> Thanks,
> Zorro
> 
>>   	[ $? -ne 0 ] && _notrun "quota sysfile not enabled in this device $_dev"
>>   	cat /sys/fs/f2fs/features/project_quota | grep -qw supported
>>   	[ $? -ne 0 ] && _notrun "Installed kernel does not support project quotas"
>> -- 
>> 2.40.1
>>
>>
> 


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
