Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1EEBCD4F21
	for <linux-f2fs-devel@archiver.kernel.org>; Sat, 16 May 2026 14:48:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=n0DBuOk+qEnBhZCSVwyThNcO8cWJ2TVXMEzyI5GgCPo=; b=jhd8w7ZQSbD5or+RR3aVgWoSmn
	/yLh2KjIaigdv4gQ7f/vfTBvZMofyh0q3vNl6VtlRvCHHwp9AtvylbApBidjCYUwDl2BQSsXucNUb
	YWmOjxlumxYw8zQzfEOfmfd5mH+1YGiOEehoVCXsajWo6bNZYOVuj5V3QVpSexn3J2j4=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wOGJQ-0001og-KH;
	Sat, 16 May 2026 14:48:21 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <cel@kernel.org>) id 1wOGJP-0001oZ-6K
 for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 16 May 2026 14:48:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=FaYW1px7GhIecp1gpI6svNvRoAjQz9PiFAs7DV8Q5bY=; b=loA5bCqT1hu7QxkVc2Iu/8Qtz3
 oXjA2AMyUL54ekp0vuuW8noJhe1FHrxVuD1gbeju0bWQtVaSv8glvKxvOgKslpP9dnPH2DRJ5+FaF
 cn8MI7U/spm5qgc/dM4Das5Vxwll/IbiQ2SwN4MveZ2ZyShbeRCMk531jpdXnzV/AkOY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=FaYW1px7GhIecp1gpI6svNvRoAjQz9PiFAs7DV8Q5bY=; b=M7U2TAFjpfVKaGJaEzlECarodP
 NHjhWqGe3z1Ed0wwGXBTZCHqiHTnVRsMN/kH7dZIrosbCjCv39G2BC8vl1KUyvPODUjnNg8ZPY9tZ
 TX4qC/h9fNbCC5753n28X8J5NVYpvNHoMWkfY/dUhElKt/RLtH1RClKZA0dAvTgtcSLo=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wOGJO-000478-OS for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 16 May 2026 14:48:19 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 9084260142;
 Sat, 16 May 2026 14:48:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C461BC19425;
 Sat, 16 May 2026 14:48:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1778942893;
 bh=7VKUyExfAKl6AIwgWrTe81uA918+1Nlb2thIYy7wew0=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=kmCMUw2wAu2HkSbRkoupAhLOXnjqM12FHAs2KElCaFrONYwgYk2vYb0j7YYOpHeCa
 N+S2jUgpYKJ6ztqopeRqYBV9zRykHAXXqdYnkQEC6acv4C0j/wwgtHGNGHQVNlWKvN
 dPsrPSddnFN0sDy04Zfk9ZyMhQpx3QPvmPmEInI7qq/tbj7NBnbeUQ4/s6ZEmawm4u
 EiP+KaZ9XpyVG6szke+fZ2+PJe+tz4U1TVDkuW3BkrdGo/VHSXd7KErOcnAP/SQG7B
 6lVhvYT3oJdGI/p7u6rXpzGQxf4SOtQ3g8uWA2EcFb2DAjjFgp9dRz8pFoxZyaD2KW
 pi+DBfaRE95TA==
Message-ID: <bd45e387-cc11-4d19-8bd6-58a0251d7714@kernel.org>
Date: Sat, 16 May 2026 10:48:09 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Cedric Blancher <cedric.blancher@gmail.com>,
 Christian Brauner <brauner@kernel.org>
References: <20260507-case-sensitivity-v14-0-e62cc8200435@oracle.com>
 <20260511-wertverlust-vorbringen-070f016f3bd4@brauner>
 <CALXu0UdsurG-ayuYViqs0HXOfgyDw8gpNC+f=5y59cuuSPUbBA@mail.gmail.com>
Content-Language: en-US
Organization: kernel.org
In-Reply-To: <CALXu0UdsurG-ayuYViqs0HXOfgyDw8gpNC+f=5y59cuuSPUbBA@mail.gmail.com>
X-Headers-End: 1wOGJO-000478-OS
Subject: Re: [f2fs-dev] [PATCH v14 00/15] Exposing case folding behavior
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
From: Chuck Lever via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Chuck Lever <cel@kernel.org>
Cc: pc@manguebit.org, yuezhang.mo@sony.com, cem@kernel.org,
 Roland Mainz <roland.mainz@nrubsig.org>,
 almaz.alexandrovich@paragon-software.com, adilger.kernel@dilger.ca,
 linux-cifs@vger.kernel.org, sfrench@samba.org, slava@dubeyko.com,
 "Darrick J. Wong" <djwong@kernel.org>, linux-ext4@vger.kernel.org,
 linkinjeon@kernel.org, Steve French <stfrench@microsoft.com>,
 sprasad@microsoft.com, frank.li@vivo.com, ronniesahlberg@gmail.com,
 glaubitz@physik.fu-berlin.de, jaegeuk@kernel.org, hirofumi@mail.parknet.co.jp,
 linux-nfs@vger.kernel.org, tytso@mit.edu, linux-api@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org,
 senozhatsky@chromium.org, Chuck Lever <chuck.lever@oracle.com>,
 hansg@kernel.org, anna@kernel.org, linux-fsdevel@vger.kernel.org,
 sj1557.seo@samsung.com, trondmy@kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 5/16/26 2:43 AM, Cedric Blancher wrote:
> On Mon, 11 May 2026 at 16:11, Christian Brauner <brauner@kernel.org> wrote:
>>
>> On Thu, 07 May 2026 04:52:53 -0400, Chuck Lever wrote:
>>> Christian, let's lock this one in. I will post subsequent changes
>>> as delta patches.
>>>
>>> Following on from:
>>>
>>> https://lore.kernel.org/linux-nfs/20251021-zypressen-bazillus-545a44af57fd@brauner/T/#m0ba197d75b7921d994cf284f3cef3a62abb11aaa
>>>
>>> [...]
>>
>> Applied to the vfs-7.2.exportfs branch of the vfs/vfs.git tree.
>> Patches in the vfs-7.2.exportfs branch should appear in linux-next soon.
> 
> @Chuck Lever Thank you!
> 
> Does that mean the support for case-insensitive filesystems will work
> with Linux 7.2?

I don't want to make claims with 100% certainty, but we expect this
series to get merged into 7.2. It's early days, so there are likely to
be bugs -- there is so much subtle behavior under the covers.


-- 
Chuck Lever


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
