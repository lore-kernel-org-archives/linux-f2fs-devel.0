Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB05EC433EF
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 23 Jun 2022 16:36:33 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.94.2)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1o4Pol-00054M-Ci; Thu, 23 Jun 2022 16:36:31 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <krisman@collabora.com>) id 1o4Poj-00054G-Oq
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 23 Jun 2022 16:36:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:MIME-Version:Message-ID:In-Reply-To:
 Date:References:Subject:Cc:To:From:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=NQisR1PM5H6nLeU8Bs6yXgmrXILbvW+nrf6n/qymaRY=; b=WqVZ19hOepD8seTUFZwYFT/dyV
 HqlqoaJXTEUSwwO2ajgiRbTEpEDqFGUfDz23JAfbBCxNKJmqpjIIi4oKEOY7/CkteDrpXL9D42Gwn
 6NIeHJb7y0k51fBpz2gtM6i/BK+Z5h80txd44bc5z3J+Jsf8n/+F7XpJf13bGzaauU8o=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:MIME-Version:Message-ID:In-Reply-To:Date:References:Subject:
 Cc:To:From:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=NQisR1PM5H6nLeU8Bs6yXgmrXILbvW+nrf6n/qymaRY=; b=BbA7Xqv/48Lr6NyBQ4ESYiHfiJ
 6vIBJ8/CpTZCEr3DsOgO+2iu9puvq3qtJ0CCHpgVSbvrinvYLR6LxLQ2xiuc2o+NCQzuIC0OXEUD5
 pKpulnE9zu4+9AoPz4rZC3ehSCFfVYi2G/o6eWMEKNhaVFXtkeKUmJz2sAIwLlgDVdaM=;
Received: from madras.collabora.co.uk ([46.235.227.172])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.94.2)
 id 1o4Pog-0001N7-52
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 23 Jun 2022 16:36:29 +0000
Received: from localhost (modemcable141.102-20-96.mc.videotron.ca
 [96.20.102.141])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: krisman)
 by madras.collabora.co.uk (Postfix) with ESMTPSA id 8888066017DF;
 Thu, 23 Jun 2022 17:36:19 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1656002179;
 bh=xBl8A27Ms8S+5lzaIzajGkuNErZevkNTF10THb9C3M0=;
 h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
 b=G3xyWOp1DA3bCpt0o339Cuq7jQstFFo+ddrZn4agrJrh/RHmxxyGzPqEZsgRw7DEb
 lzyw80VcZ5txS+ka5g+VuLOz0fAL2mdPORc7tg5Uy0Yzgn8knfZEGFW4dPy4mbtnrX
 MVQb1C0C6LDhDlyBBa7mtUgjyQRfmBMysO2ug4p+Oc8cTykyCOG0rz0v+Qbiuvhl3a
 NxpD17y570G38p9Xf8iMTQMGY1bePhas7Sd5NNLKG1vLGAaKuAtbijkKAnhcL49EEy
 y7mQqqIYQ9mvd/skaUkR8cxmTSSFP8mZs7frOmFzp6120DMVXoWkzFLKVbugb8y3Ec
 bUXX+Xaag5rMw==
From: Gabriel Krisman Bertazi <krisman@collabora.com>
To: kernel test robot <lkp@intel.com>
Organization: Collabora
References: <20220622194603.102655-7-krisman@collabora.com>
 <202206231550.0JrilBjp-lkp@intel.com>
Date: Thu, 23 Jun 2022 12:36:15 -0400
In-Reply-To: <202206231550.0JrilBjp-lkp@intel.com> (kernel test robot's
 message of "Thu, 23 Jun 2022 15:29:07 +0800")
Message-ID: <875ykr2v7k.fsf@collabora.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
X-Headers-End: 1o4Pog-0001N7-52
Subject: Re: [f2fs-dev] [PATCH 6/7] ext4: Enable negative dentries on
 case-insensitive lookup
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
Cc: kernel@collabora.com, tytso@mit.edu, kbuild-all@lists.01.org,
 linux-f2fs-devel@lists.sourceforge.net, ebiggers@kernel.org,
 viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org, jaegeuk@kernel.org,
 linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

kernel test robot <lkp@intel.com> writes:

> Hi Gabriel,
>
> I love your patch! Yet something to improve:
>
> [auto build test ERROR on tytso-ext4/dev]
> [also build test ERROR on jaegeuk-f2fs/dev-test linus/master v5.19-rc3 next-20220622]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch]
>
> url:    https://github.com/intel-lab-lkp/linux/commits/Gabriel-Krisman-Bertazi/Support-negative-dentries-on-case-insensitive-directories/20220623-034942
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git dev
> config: x86_64-randconfig-a006 (https://download.01.org/0day-ci/archive/20220623/202206231550.0JrilBjp-lkp@intel.com/config)
> compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
> reproduce (this is a W=1 build):
>         # https://github.com/intel-lab-lkp/linux/commit/69488ccc517a48af2f1cec0efb84651397edf6f6
>         git remote add linux-review https://github.com/intel-lab-lkp/linux
>         git fetch --no-tags linux-review Gabriel-Krisman-Bertazi/Support-negative-dentries-on-case-insensitive-directories/20220623-034942
>         git checkout 69488ccc517a48af2f1cec0efb84651397edf6f6
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash
>
> If you fix the issue, kindly add following tag where applicable
> Reported-by: kernel test robot <lkp@intel.com>
>
> All errors (new ones prefixed by >>, old ones prefixed by <<):
>
>>> ERROR: modpost: "d_set_casefold_lookup" [fs/ext4/ext4.ko] undefined!

Hm, missing the EXPORT_SYMBOL() since this is called from filesystems.
I will add it for v2.

-- 
Gabriel Krisman Bertazi


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
