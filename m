Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A080EB64DD
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 17 Aug 2023 09:13:40 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1qWZ4T-00076D-SZ;
	Thu, 17 Aug 2023 09:13:38 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <lkp@intel.com>) id 1qWZ4S-000767-B0
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 17 Aug 2023 09:13:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=t3JCtvC1DHSxjHwEHuULpLZgwN6g1OeDVVGMsY1/GZQ=; b=Hk2NV/Z4TbILz9Kj+0YBW3fPlm
 f0LINS6SNxoi13Q8E43oG89uAzBlmRdz2WocCj8IH/NkeVsvGJO2jYKWlfxJTkkBR7JpbPz7xBEmn
 sfTqrdNUo03mDJcmLuqG19SlrITyV36/51RPycU+0UbTKM25TKFuXN08CvKeZE6h/Vi0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=t3JCtvC1DHSxjHwEHuULpLZgwN6g1OeDVVGMsY1/GZQ=; b=lCnZoLU0wjfjx48DYj1mZ5keDj
 Hs47xao6TvFy3rrCIV6MG/SvuijjWarHRAFnC+HXtRwtMxC/RnwFK599UAn9RagWMJ3W6Of1hOcyu
 1piotcfSUaALitzW70CcSbeZuBv6zcVPsCqnNrt3sSZTm+JLhHrIbEkIH9WuSadKQEwU=;
Received: from mgamail.intel.com ([192.55.52.93])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1qWZ4P-0002Qy-M1 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 17 Aug 2023 09:13:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1692263613; x=1723799613;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=4z/FYGQdd8TUJLtwj7tIzG3gTwFirQUpcAAlf+5kjMw=;
 b=MBnhtU0yKQH9C8iugYK0XdBVxq7RrDrLHdbtOPTIlesFfuDp+9PUzD+e
 +nHubF6+b5SLSeMRYrCHz6KD+6ZPiOfnWbWpOuMpR8f0xt6sx5qHWaiyk
 NNzdZtYDihsgLrCm1X/McpAmWpC4hJ690IFBpCSTTLWkHv/dHk1lZrKUP
 Oscil8VrprjWivM8yaCbdMiYEg9A3dRU+f0jWt0go1gkLmClPu197L6uQ
 13F5Z+yWdfcDtRaQdh7qgIkpZuGhd2sALlN5cvKgxrqIsZEkbL//5iA70
 /MT9rsTclVgl/3YV53WMD3hFnzqFZU+YY9dvGHNx63Y/XyVJjQ4ji0iTi A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="370225032"
X-IronPort-AV: E=Sophos;i="6.01,179,1684825200"; d="scan'208";a="370225032"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Aug 2023 02:13:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="737630385"
X-IronPort-AV: E=Sophos;i="6.01,179,1684825200"; d="scan'208";a="737630385"
Received: from lkp-server02.sh.intel.com (HELO a9caf1a0cf30) ([10.239.97.151])
 by fmsmga007.fm.intel.com with ESMTP; 17 Aug 2023 02:13:22 -0700
Received: from kbuild by a9caf1a0cf30 with local (Exim 4.96)
 (envelope-from <lkp@intel.com>) id 1qWZ4D-0000zb-2N;
 Thu, 17 Aug 2023 09:13:21 +0000
Date: Thu, 17 Aug 2023 17:12:58 +0800
From: kernel test robot <lkp@intel.com>
To: Gabriel Krisman Bertazi <krisman@suse.de>, viro@zeniv.linux.org.uk,
 brauner@kernel.org, tytso@mit.edu, ebiggers@kernel.org, jaegeuk@kernel.org
Message-ID: <202308171740.0u9DuWtr-lkp@intel.com>
References: <20230812004146.30980-5-krisman@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230812004146.30980-5-krisman@suse.de>
X-Headers-End: 1qWZ4P-0002Qy-M1
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
Cc: Gabriel Krisman Bertazi <krisman@suse.de>, llvm@lists.linux.dev,
 linux-f2fs-devel@lists.sourceforge.net, oe-kbuild-all@lists.linux.dev,
 linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hi Gabriel,

kernel test robot noticed the following build warnings:

[auto build test WARNING on tytso-ext4/dev]
[also build test WARNING on linus/master]
[cannot apply to tyhicks-ecryptfs/next ericvh-v9fs/for-next viro-vfs/for-next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Gabriel-Krisman-Bertazi/fs-Expose-helper-to-check-if-a-directory-needs-casefolding/20230812-084506
base:   https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git dev
patch link:    https://lore.kernel.org/r/20230812004146.30980-5-krisman%40suse.de
patch subject: [PATCH v5 04/10] fs: Expose name under lookup to d_revalidate hooks
config: x86_64-randconfig-x012-20230817 (https://download.01.org/0day-ci/archive/20230817/202308171740.0u9DuWtr-lkp@intel.com/config)
compiler: clang version 16.0.4 (https://github.com/llvm/llvm-project.git ae42196bc493ffe877a7e3dff8be32035dea4d07)
reproduce: (https://download.01.org/0day-ci/archive/20230817/202308171740.0u9DuWtr-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202308171740.0u9DuWtr-lkp@intel.com/

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
