Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D50DBC636D4
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 17 Feb 2023 13:20:16 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1pT0et-0000pj-1Q;
	Fri, 17 Feb 2023 13:20:15 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <regressions@leemhuis.info>) id 1pT0es-0000pd-N5
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 17 Feb 2023 13:20:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 Reply-To:References:To:From:Subject:MIME-Version:Date:Message-ID:Sender:Cc:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=vg6DLLrsJwwbuCXw8t+1zNdpAFnoKkIOG43np4OhKwk=; b=GBMLQKMqYVzNwxQzWGM7pIw9mr
 FI7MMXkMoShVUCzLCB+2iSf38KQ6zI0/UnEvDA+1Hmc2Hqaxdt5oA5/HtMZHXPuD1pZGerMYnjXW6
 xaIHFmY09/dVH0ORlpbjddcc7/pOsihvskegjSCQLG0tvJo1Cc7N/MMN6NHVh5BeUIRc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:Reply-To:References:To
 :From:Subject:MIME-Version:Date:Message-ID:Sender:Cc:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=vg6DLLrsJwwbuCXw8t+1zNdpAFnoKkIOG43np4OhKwk=; b=NsFHA/i3tuxTOijUp/7LjW1VIf
 tu2RpOcOu56M3/Q41yCD19XNgosTQCFB/LrrtBhH3+iJKEhzHxv048dkZqYlSlj56dRZMHnSoqxjV
 ERivM8iPWLhCRBI9sFZChEnNyhSgx9tJtu6pt/M+xw1uTOXXsaE2NlLlRLjKQUAWno/M=;
Received: from wp530.webpack.hosteurope.de ([80.237.130.52])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1pT0eq-007LJm-V5 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 17 Feb 2023 13:20:14 +0000
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
 by wp530.webpack.hosteurope.de running ExIM with esmtpsa
 (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 id 1pT09p-00088a-MQ; Fri, 17 Feb 2023 13:48:09 +0100
Message-ID: <86281fdf-2cea-0fec-d17d-4d6ac3a58176@leemhuis.info>
Date: Fri, 17 Feb 2023 13:48:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Content-Language: en-US, de-DE
From: "Linux regression tracking (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
To: Jeff Chua <jeff.chua.linux@gmail.com>, lkml <linux-kernel@vger.kernel.org>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Bagas Sanjaya <bagasdotme@gmail.com>, Jaegeuk Kim <jaegeuk@kernel.org>,
 Chao Yu <chao@kernel.org>,
 F2FS Development <linux-f2fs-devel@lists.sourceforge.net>,
 Linux Regressions <regressions@lists.linux.dev>
References: <CAAJw_Ztzyh-GNTJYpXbA0CeJv2Rz=fLZKE6_Q=7JMmM+s9yHXQ@mail.gmail.com>
 <CAAJw_Ztb0mJVkHtBhryf=9g8CA0fZZRa8HVio8GCGUSLOvqa7A@mail.gmail.com>
 <Y6bz4wOC0nwu2yGU@debian.me> <0c70ba66-ef00-7242-d198-844f803662fa@gmail.com>
 <CAAJw_Zv0iBg4rkzxQ2UOOLS9JQZ4cCmM7gSoDXec_gm-GggB6A@mail.gmail.com>
 <f500d64b-c26d-ee34-092a-421c64c69f9e@leemhuis.info>
In-Reply-To: <f500d64b-c26d-ee34-092a-421c64c69f9e@leemhuis.info>
X-bounce-key: webpack.hosteurope.de; regressions@leemhuis.info; 1676640013;
 95d09de3; 
X-HE-SMSGID: 1pT09p-00088a-MQ
X-Headers-End: 1pT0eq-007LJm-V5
Subject: Re: [f2fs-dev] Fwd: f2fs write error Linux v6.2
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
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

[TLDR: This mail in primarily relevant for Linux regression tracking. A
change or fix related to the regression discussed in this thread was
posted or applied, but it did not use a Link: tag to point to the
report, as Linus and the documentation call for. Things happen, no
worries -- but now the regression tracking bot needs to be told manually
about the fix. See link in footer if these mails annoy you.]

On 30.12.22 06:56, Thorsten Leemhuis wrote:
> On 30.12.22 05:04, Jeff Chua wrote:
>> On 12/24/22 19:43, Bagas Sanjaya wrote:
>>> On Sat, Dec 24, 2022 at 01:48:55PM +0800, Jeff Chua wrote:
>>>> Got the following error in latest linux-6.2-git with just vim (:w
>>>> file1). No problem with linux-6.1.1
>>
>> What happened to the f2fs developers? No response from anyone yet.
> 
> Well, that indeed is unfortunate and ideally shouldn't happen, but the
> simple reality is: that can happen this time of the year due to this
> thing called "festive season".
> [...]

#regzbot fix: b3d83066cbebc76dbac8a5fca931f64b4c6fff34
#regzbot ignore-activity

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
That page also explains what to do if mails like this annoy you.



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
