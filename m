From: Eric Biggers <ebiggers@kernel.org>
Subject: Re: [PATCH V2 3/7] fscrypt: remove filesystem specific
 build config option
Date: Tue, 11 Dec 2018 18:48:12 -0800
Message-ID: <20181212024811.GB722@sol.localdomain>
References: <20181204095650.12562-1-chandan@linux.vnet.ibm.com>
 <20181204095650.12562-4-chandan@linux.vnet.ibm.com>
 <20181212015211.GA23905@roeck-us.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <ebiggers@kernel.org>) id 1gWuZT-0002Un-S2
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 12 Dec 2018 02:48:23 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1gWuZQ-00CM6x-Gq
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 12 Dec 2018 02:48:23 +0000
Content-Disposition: inline
In-Reply-To: <20181212015211.GA23905@roeck-us.net>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Guenter Roeck <linux@roeck-us.net>, Chandan Rajendra <chandan@linux.vnet.ibm.com>
Cc: linux-mips@linux-mips.org, linux-doc@vger.kernel.org, jhogan@kernel.org, heiko.carstens@de.ibm.com, linux-mtd@lists.infradead.org, deanbo422@gmail.com, linux-s390@vger.kernel.org, corbet@lwn.net, richard@nod.at, linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org, green.hu@gmail.com, jaegeuk@kernel.org, tytso@mit.edu, dedekind1@gmail.com, adrian.hunter@intel.com, ralf@linux-mips.org, linux-f2fs-devel@lists.sourceforge.net, paul.burton@mips.com, schwidefsky@de.ibm.com, adilger.kernel@dilger.ca, viro@zeniv.linux.org.uk

On Tue, Dec 11, 2018 at 05:52:11PM -0800, Guenter Roeck wrote:
> Hi,
> 
> On Tue, Dec 04, 2018 at 03:26:46PM +0530, Chandan Rajendra wrote:
> > In order to have a common code base for fscrypt "post read" processing
> > for all filesystems which support encryption, this commit removes
> > filesystem specific build config option (e.g. CONFIG_EXT4_FS_ENCRYPTION)
> > and replaces it with a build option (i.e. CONFIG_FS_ENCRYPTION) whose
> > value affects all the filesystems making use of fscrypt.
> > 
> > Signed-off-by: Chandan Rajendra <chandan@linux.vnet.ibm.com>
> 
> this patch causes a recursive dependency when trying to build ia64 images.
> 
> make ARCH=ia64 allnoconfig:
> 
> scripts/kconfig/conf  --allnoconfig Kconfig
> arch/ia64/Kconfig:126:error: recursive dependency detected!
> arch/ia64/Kconfig:126:	choice <choice> contains symbol IA64_HP_SIM
> arch/ia64/Kconfig:200:	symbol IA64_HP_SIM is part of choice PM
> kernel/power/Kconfig:144:	symbol PM is selected by PM_SLEEP
> kernel/power/Kconfig:104:	symbol PM_SLEEP depends on HIBERNATE_CALLBACKS
> kernel/power/Kconfig:31:	symbol HIBERNATE_CALLBACKS is selected by HIBERNATION
> kernel/power/Kconfig:34:	symbol HIBERNATION depends on SWAP
> init/Kconfig:250:	symbol SWAP depends on BLOCK
> block/Kconfig:5:	symbol BLOCK is selected by UBIFS_FS
> fs/ubifs/Kconfig:1:	symbol UBIFS_FS depends on MISC_FILESYSTEMS
> fs/Kconfig:220:	symbol MISC_FILESYSTEMS is selected by ACPI_APEI
> drivers/acpi/apei/Kconfig:8:	symbol ACPI_APEI depends on ACPI
> drivers/acpi/Kconfig:9:	symbol ACPI depends on ARCH_SUPPORTS_ACPI
> drivers/acpi/Kconfig:6:	symbol ARCH_SUPPORTS_ACPI is selected by IA64_HP_SIM
> arch/ia64/Kconfig:200:	symbol IA64_HP_SIM is part of choice <choice>
> For a resolution refer to Documentation/kbuild/kconfig-language.txt
> subsection "Kconfig recursive dependency limitations"
> 
> scripts/kconfig/Makefile:69: recipe for target 'allnoconfig' failed
> 
> Reverting the patch fixes the problem.
> 

Thanks for the report.  Chandan, it appears the problem is UBIFS_FS selecting
BLOCK.  It's actually not necessary because now the parts of fs/crypto/ that
depend on BLOCK are separated out into a separate file fs/crypto/bio.c that is
only compiled with CONFIG_BLOCK.  So how about just removing the selection of
BLOCK from fs/ubifs/Kconfig:

	select BLOCK if FS_ENCRYPTION

- Eric
