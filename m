Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C8B8C2FC0E
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 17 Aug 2023 07:01:30 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1qWX0Z-0005aU-Cp;
	Thu, 17 Aug 2023 07:01:27 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <lkp@intel.com>) id 1qWX0U-0005aN-3m
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 17 Aug 2023 07:01:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=3yMvAdCinpCIqSfMiDNrH5zbO9yBUblPHfAauSICQZM=; b=KqiAkvKzw96woFREHcP3R7ZitB
 ESk5ewmZiKHmPaXAyG9aTxJyYcFlWd18tJFVCSlFewy8MIrAuNsvB+L5zBP/1OgYNXXritN+jDOsZ
 WvBrEqSGLWtVSY19SdL3W+K+7JUIfeDEFPkd9Nl/1GyzwDPKWb0mBC/mDN37GCXTI2L4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=3yMvAdCinpCIqSfMiDNrH5zbO9yBUblPHfAauSICQZM=; b=ixNZAjQTbMyXhTuWYOUq6vbVwJ
 UrBWplX4c4aCvEeL+YhTr4yAA7NGHDIv3dSzrm7C6tAotCSKKgJUh5VGsIMME9iylaRgtYN4mC/zL
 FbrpmEg3Fxf7lp2F7fu2gHR8mkp2OfDUrEHbH3tw9DFFY9ZY1lPQZBSc5X1x02/sgliY=;
Received: from mgamail.intel.com ([192.55.52.88])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1qWX0Q-0005yx-W9 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 17 Aug 2023 07:01:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1692255678; x=1723791678;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=zJecru2MS+4Qam6WJWWn6XOWJpvEESf1Ln+mn83CJjU=;
 b=iX55hM1XhRP/78lk4Qf3ZKO88828I4S0A+pKrlouf3lJBM6gMxIWBf50
 Ywe0tneh7yuxZwAe9iqpak6plfJGECelhCisY6LM6KBXTE/CQMLzm/Pyb
 o/8UUQvdECcd/FtZmQp4NP0UtX6ze283ieBH6Wsm/2IC2nF+/OmuN2Lui
 lmbZ4DwCsbq18pF4MRQsIoh6IF3Mjaf1wJ31q6pgwH4R0DfHXP4ed18yc
 aU7yPunp0v3n8z3cWP9qM4focePVEh4m7ksCaDTBHCEuxHBsuCZwB3uvD
 xe7z9bEq5GDBtMM13HPNKFXrj4aEeJjwK9gC5xgVycBXJg+uA6/gqsCoZ Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="403711265"
X-IronPort-AV: E=Sophos;i="6.01,179,1684825200"; d="scan'208";a="403711265"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Aug 2023 00:01:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="711421261"
X-IronPort-AV: E=Sophos;i="6.01,179,1684825200"; d="scan'208";a="711421261"
Received: from lkp-server02.sh.intel.com (HELO a9caf1a0cf30) ([10.239.97.151])
 by orsmga006.jf.intel.com with ESMTP; 17 Aug 2023 00:01:10 -0700
Received: from kbuild by a9caf1a0cf30 with local (Exim 4.96)
 (envelope-from <lkp@intel.com>) id 1qWX0H-0000sI-28;
 Thu, 17 Aug 2023 07:01:09 +0000
Date: Thu, 17 Aug 2023 15:00:39 +0800
From: kernel test robot <lkp@intel.com>
To: Gabriel Krisman Bertazi <krisman@suse.de>, viro@zeniv.linux.org.uk,
 brauner@kernel.org, tytso@mit.edu, ebiggers@kernel.org, jaegeuk@kernel.org
Message-ID: <202308171453.3HpCqtib-lkp@intel.com>
References: <20230812004146.30980-5-krisman@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230812004146.30980-5-krisman@suse.de>
X-Headers-End: 1qWX0Q-0005yx-W9
Subject: Re: [f2fs-dev] [PATCH v5 04/10] fs: Expose name under lookup to
 d_revalidate hooks
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
Cc: linux-fsdevel@vger.kernel.org, Gabriel Krisman Bertazi <krisman@suse.de>,
 linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 oe-kbuild-all@lists.linux.dev
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hi Gabriel,

kernel test robot noticed the following build warnings:

[auto build test WARNING on tytso-ext4/dev]
[also build test WARNING on linus/master]
[cannot apply to tyhicks-ecryptfs/next ericvh-v9fs/for-next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Gabriel-Krisman-Bertazi/fs-Expose-helper-to-check-if-a-directory-needs-casefolding/20230812-084506
base:   https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git dev
patch link:    https://lore.kernel.org/r/20230812004146.30980-5-krisman%40suse.de
patch subject: [PATCH v5 04/10] fs: Expose name under lookup to d_revalidate hooks
config: mips-randconfig-r002-20230817 (https://download.01.org/0day-ci/archive/20230817/202308171453.3HpCqtib-lkp@intel.com/config)
compiler: mipsel-linux-gcc (GCC) 12.3.0
reproduce: (https://download.01.org/0day-ci/archive/20230817/202308171453.3HpCqtib-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202308171453.3HpCqtib-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> fs/ecryptfs/dentry.c:33: warning: Function parameter or member 'name' not described in 'ecryptfs_d_revalidate'


vim +33 fs/ecryptfs/dentry.c

237fead619984c Michael Halcrow         2006-10-04  17  
237fead619984c Michael Halcrow         2006-10-04  18  /**
237fead619984c Michael Halcrow         2006-10-04  19   * ecryptfs_d_revalidate - revalidate an ecryptfs dentry
237fead619984c Michael Halcrow         2006-10-04  20   * @dentry: The ecryptfs dentry
0b728e1911cbe6 Al Viro                 2012-06-10  21   * @flags: lookup flags
237fead619984c Michael Halcrow         2006-10-04  22   *
237fead619984c Michael Halcrow         2006-10-04  23   * Called when the VFS needs to revalidate a dentry. This
237fead619984c Michael Halcrow         2006-10-04  24   * is called whenever a name lookup finds a dentry in the
237fead619984c Michael Halcrow         2006-10-04  25   * dcache. Most filesystems leave this as NULL, because all their
237fead619984c Michael Halcrow         2006-10-04  26   * dentries in the dcache are valid.
237fead619984c Michael Halcrow         2006-10-04  27   *
237fead619984c Michael Halcrow         2006-10-04  28   * Returns 1 if valid, 0 otherwise.
237fead619984c Michael Halcrow         2006-10-04  29   *
237fead619984c Michael Halcrow         2006-10-04  30   */
0838ae103beaf6 Gabriel Krisman Bertazi 2023-08-11  31  static int ecryptfs_d_revalidate(struct dentry *dentry,
0838ae103beaf6 Gabriel Krisman Bertazi 2023-08-11  32  				 const struct qstr *name, unsigned int flags)
237fead619984c Michael Halcrow         2006-10-04 @33  {
2edbfbf1c1ab0a Al Viro                 2013-09-15  34  	struct dentry *lower_dentry = ecryptfs_dentry_to_lower(dentry);
5556e7e6d30e8e Tyler Hicks             2015-08-05  35  	int rc = 1;
237fead619984c Michael Halcrow         2006-10-04  36  
0b728e1911cbe6 Al Viro                 2012-06-10  37  	if (flags & LOOKUP_RCU)
34286d6662308d Nicholas Piggin         2011-01-07  38  		return -ECHILD;
34286d6662308d Nicholas Piggin         2011-01-07  39  
5556e7e6d30e8e Tyler Hicks             2015-08-05  40  	if (lower_dentry->d_flags & DCACHE_OP_REVALIDATE)
0838ae103beaf6 Gabriel Krisman Bertazi 2023-08-11  41  		rc = lower_dentry->d_op->d_revalidate(lower_dentry, name, flags);
5556e7e6d30e8e Tyler Hicks             2015-08-05  42  
2b0143b5c986be David Howells           2015-03-17  43  	if (d_really_is_positive(dentry)) {
5556e7e6d30e8e Tyler Hicks             2015-08-05  44  		struct inode *inode = d_inode(dentry);
ae56fb16337c88 Michael Halcrow         2006-11-16  45  
5556e7e6d30e8e Tyler Hicks             2015-08-05  46  		fsstack_copy_attr_all(inode, ecryptfs_inode_to_lower(inode));
5556e7e6d30e8e Tyler Hicks             2015-08-05  47  		if (!inode->i_nlink)
5556e7e6d30e8e Tyler Hicks             2015-08-05  48  			return 0;
ae56fb16337c88 Michael Halcrow         2006-11-16  49  	}
237fead619984c Michael Halcrow         2006-10-04  50  	return rc;
237fead619984c Michael Halcrow         2006-10-04  51  }
237fead619984c Michael Halcrow         2006-10-04  52  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
