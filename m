From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [f2fs:dev-test 15/23] fs//f2fs/super.c:830:2: error:
 too many arguments to function 'f2fs_wait_discard_bios'
Date: Wed, 11 Oct 2017 09:22:08 +0800
Message-ID: <cee08ebc-7397-8c81-586b-f74f3c5b45da@huawei.com>
References: <201710110240.fDBixdgs%fengguang.wu@intel.com>
 <20171010183243.GD6455@jaegeuk-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
 helo=mx.sourceforge.net)
 by sfs-ml-1.v29.ch3.sourceforge.com with esmtps (TLSv1:DHE-RSA-AES256-SHA:256)
 (Exim 4.89) (envelope-from <yuchao0@huawei.com>) id 1e25lV-00032g-UV
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 11 Oct 2017 01:24:53 +0000
Received: from szxga05-in.huawei.com ([45.249.212.191])
 by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
 (Exim 4.76) id 1e25lS-0007im-TC
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 11 Oct 2017 01:24:53 +0000
In-Reply-To: <20171010183243.GD6455@jaegeuk-macbookpro.roam.corp.google.com>
Content-Language: en-US
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Jaegeuk Kim <jaegeuk@kernel.org>, kbuild test robot <fengguang.wu@intel.com>
Cc: kbuild-all@01.org, linux-f2fs-devel@lists.sourceforge.net

Ah, thank you. ;)

Thanks,

On 2017/10/11 2:32, Jaegeuk Kim wrote:
> FYI; I fixed this in the branch.
> 
> Thanks,
> 
> On 10/11, kbuild test robot wrote:
>> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git dev-test
>> head:   1b5d38c7280014133ddec78603d231006adba05b
>> commit: 5814edee9182ef648388de43df62d56f159cb5f9 [15/23] f2fs: support issuing/waiting discard in range
>> config: i386-randconfig-x008-201741 (attached as .config)
>> compiler: gcc-6 (Debian 6.2.0-3) 6.2.0 20160901
>> reproduce:
>>         git checkout 5814edee9182ef648388de43df62d56f159cb5f9
>>         # save the attached .config to linux build tree
>>         make ARCH=i386 
>>
>> Note: the f2fs/dev-test HEAD 1b5d38c7280014133ddec78603d231006adba05b builds fine.
>>       It only hurts bisectibility.
>>
>> All errors (new ones prefixed by >>):
>>
>>    fs//f2fs/super.c: In function 'f2fs_put_super':
>>>> fs//f2fs/super.c:830:2: error: too many arguments to function 'f2fs_wait_discard_bios'
>>      f2fs_wait_discard_bios(sbi, true);
>>      ^~~~~~~~~~~~~~~~~~~~~~
>>    In file included from fs//f2fs/super.c:30:0:
>>    fs//f2fs/f2fs.h:2551:6: note: declared here
>>     void f2fs_wait_discard_bios(struct f2fs_sb_info *sbi);
>>          ^~~~~~~~~~~~~~~~~~~~~~
>>    In file included from include/uapi/linux/stddef.h:1:0,
>>                     from include/linux/stddef.h:4,
>>                     from include/uapi/linux/posix_types.h:4,
>>                     from include/uapi/linux/types.h:13,
>>                     from include/linux/types.h:5,
>>                     from include/linux/list.h:4,
>>                     from include/linux/module.h:9,
>>                     from fs//f2fs/super.c:11:
>>    fs//f2fs/super.c: At top level:
>>    include/linux/compiler.h:162:4: warning: '______f' is static but declared in inline function 'strcpy' which is not static
>>        ______f = {     \
>>        ^
>>    include/linux/compiler.h:154:23: note: in expansion of macro '__trace_if'
>>     #define if(cond, ...) __trace_if( (cond , ## __VA_ARGS__) )
>>                           ^~~~~~~~~~
>>    include/linux/string.h:421:2: note: in expansion of macro 'if'
>>      if (p_size == (size_t)-1 && q_size == (size_t)-1)
>>      ^~
>>    include/linux/compiler.h:162:4: warning: '______f' is static but declared in inline function 'kmemdup' which is not static
>>        ______f = {     \
>>        ^
>>    include/linux/compiler.h:154:23: note: in expansion of macro '__trace_if'
>>     #define if(cond, ...) __trace_if( (cond , ## __VA_ARGS__) )
>>                           ^~~~~~~~~~
>>    include/linux/string.h:411:2: note: in expansion of macro 'if'
>>      if (p_size < size)
>>      ^~
>>    include/linux/compiler.h:162:4: warning: '______f' is static but declared in inline function 'kmemdup' which is not static
>>        ______f = {     \
>>        ^
>>    include/linux/compiler.h:154:23: note: in expansion of macro '__trace_if'
>>     #define if(cond, ...) __trace_if( (cond , ## __VA_ARGS__) )
>>                           ^~~~~~~~~~
>>    include/linux/string.h:409:2: note: in expansion of macro 'if'
>>      if (__builtin_constant_p(size) && p_size < size)
>>      ^~
>>    include/linux/compiler.h:162:4: warning: '______f' is static but declared in inline function 'memchr_inv' which is not static
>>        ______f = {     \
>>        ^
>>    include/linux/compiler.h:154:23: note: in expansion of macro '__trace_if'
>>     #define if(cond, ...) __trace_if( (cond , ## __VA_ARGS__) )
>>                           ^~~~~~~~~~
>>    include/linux/string.h:400:2: note: in expansion of macro 'if'
>>      if (p_size < size)
>>      ^~
>>    include/linux/compiler.h:162:4: warning: '______f' is static but declared in inline function 'memchr_inv' which is not static
>>        ______f = {     \
>>        ^
>>    include/linux/compiler.h:154:23: note: in expansion of macro '__trace_if'
>>     #define if(cond, ...) __trace_if( (cond , ## __VA_ARGS__) )
>>                           ^~~~~~~~~~
>>    include/linux/string.h:398:2: note: in expansion of macro 'if'
>>      if (__builtin_constant_p(size) && p_size < size)
>>      ^~
>>    include/linux/compiler.h:162:4: warning: '______f' is static but declared in inline function 'memchr' which is not static
>>        ______f = {     \
>>        ^
>>    include/linux/compiler.h:154:23: note: in expansion of macro '__trace_if'
>>     #define if(cond, ...) __trace_if( (cond , ## __VA_ARGS__) )
>>                           ^~~~~~~~~~
>>    include/linux/string.h:389:2: note: in expansion of macro 'if'
>>      if (p_size < size)
>>      ^~
>>    include/linux/compiler.h:162:4: warning: '______f' is static but declared in inline function 'memchr' which is not static
>>        ______f = {     \
>>        ^
>>    include/linux/compiler.h:154:23: note: in expansion of macro '__trace_if'
>>     #define if(cond, ...) __trace_if( (cond , ## __VA_ARGS__) )
>>                           ^~~~~~~~~~
>>    include/linux/string.h:387:2: note: in expansion of macro 'if'
>>      if (__builtin_constant_p(size) && p_size < size)
>>      ^~
>>    include/linux/compiler.h:162:4: warning: '______f' is static but declared in inline function 'memcmp' which is not static
>>        ______f = {     \
>>        ^
>>    include/linux/compiler.h:154:23: note: in expansion of macro '__trace_if'
>>     #define if(cond, ...) __trace_if( (cond , ## __VA_ARGS__) )
>>                           ^~~~~~~~~~
>>    include/linux/string.h:379:2: note: in expansion of macro 'if'
>>      if (p_size < size || q_size < size)
>>      ^~
>>    include/linux/compiler.h:162:4: warning: '______f' is static but declared in inline function 'memcmp' which is not static
>>        ______f = {     \
>>        ^
>>    include/linux/compiler.h:154:23: note: in expansion of macro '__trace_if'
>>     #define if(cond, ...) __trace_if( (cond , ## __VA_ARGS__) )
>>                           ^~~~~~~~~~
>>    include/linux/string.h:376:3: note: in expansion of macro 'if'
>>       if (q_size < size)
>>       ^~
>>    include/linux/compiler.h:162:4: warning: '______f' is static but declared in inline function 'memcmp' which is not static
>>        ______f = {     \
>>        ^
>>    include/linux/compiler.h:154:23: note: in expansion of macro '__trace_if'
>>
>> vim +/f2fs_wait_discard_bios +830 fs//f2fs/super.c
>>
>> 3c62be17 Jaegeuk Kim 2016-10-06  805  
>> aff063e2 Jaegeuk Kim 2012-11-02  806  static void f2fs_put_super(struct super_block *sb)
>> aff063e2 Jaegeuk Kim 2012-11-02  807  {
>> aff063e2 Jaegeuk Kim 2012-11-02  808  	struct f2fs_sb_info *sbi = F2FS_SB(sb);
>> a398101a Chao Yu     2017-06-14  809  	int i;
>> aff063e2 Jaegeuk Kim 2012-11-02  810  
>> 0abd675e Chao Yu     2017-07-09  811  	f2fs_quota_off_umount(sb);
>> aff063e2 Jaegeuk Kim 2012-11-02  812  
>> 2658e50d Jaegeuk Kim 2015-06-19  813  	/* prevent remaining shrinker jobs */
>> 2658e50d Jaegeuk Kim 2015-06-19  814  	mutex_lock(&sbi->umount_mutex);
>> 2658e50d Jaegeuk Kim 2015-06-19  815  
>> 85dc2f2c Jaegeuk Kim 2015-01-14  816  	/*
>> 85dc2f2c Jaegeuk Kim 2015-01-14  817  	 * We don't need to do checkpoint when superblock is clean.
>> 85dc2f2c Jaegeuk Kim 2015-01-14  818  	 * But, the previous checkpoint was not done by umount, it needs to do
>> 85dc2f2c Jaegeuk Kim 2015-01-14  819  	 * clean checkpoint again.
>> 85dc2f2c Jaegeuk Kim 2015-01-14  820  	 */
>> caf0047e Chao Yu     2015-01-28  821  	if (is_sbi_flag_set(sbi, SBI_IS_DIRTY) ||
>> aaec2b1d Chao Yu     2016-09-20  822  			!is_set_ckpt_flags(sbi, CP_UMOUNT_FLAG)) {
>> 75ab4cb8 Jaegeuk Kim 2014-09-20  823  		struct cp_control cpc = {
>> 75ab4cb8 Jaegeuk Kim 2014-09-20  824  			.reason = CP_UMOUNT,
>> 75ab4cb8 Jaegeuk Kim 2014-09-20  825  		};
>> 75ab4cb8 Jaegeuk Kim 2014-09-20  826  		write_checkpoint(sbi, &cpc);
>> 75ab4cb8 Jaegeuk Kim 2014-09-20  827  	}
>> aff063e2 Jaegeuk Kim 2012-11-02  828  
>> 4e6a8d9b Jaegeuk Kim 2016-12-29  829  	/* be sure to wait for any on-going discard commands */
>> 638164a2 Chao Yu     2017-10-02 @830  	f2fs_wait_discard_bios(sbi, true);
>> 4e6a8d9b Jaegeuk Kim 2016-12-29  831  
>> 663f387b Chao Yu     2017-06-14  832  	if (f2fs_discard_en(sbi) && !sbi->discard_blks) {
>> 1f43e2ad Chao Yu     2017-04-28  833  		struct cp_control cpc = {
>> 1f43e2ad Chao Yu     2017-04-28  834  			.reason = CP_UMOUNT | CP_TRIMMED,
>> 1f43e2ad Chao Yu     2017-04-28  835  		};
>> 1f43e2ad Chao Yu     2017-04-28  836  		write_checkpoint(sbi, &cpc);
>> 1f43e2ad Chao Yu     2017-04-28  837  	}
>> 1f43e2ad Chao Yu     2017-04-28  838  
>> eca616f8 Jaegeuk Kim 2015-06-15  839  	/* write_checkpoint can update stat informaion */
>> eca616f8 Jaegeuk Kim 2015-06-15  840  	f2fs_destroy_stats(sbi);
>> eca616f8 Jaegeuk Kim 2015-06-15  841  
>> cf779cab Jaegeuk Kim 2014-08-11  842  	/*
>> cf779cab Jaegeuk Kim 2014-08-11  843  	 * normally superblock is clean, so we need to release this.
>> cf779cab Jaegeuk Kim 2014-08-11  844  	 * In addition, EIO will skip do checkpoint, we need this as well.
>> cf779cab Jaegeuk Kim 2014-08-11  845  	 */
>> 74ef9241 Jaegeuk Kim 2016-05-02  846  	release_ino_entry(sbi, true);
>> 6f12ac25 Jaegeuk Kim 2014-08-19  847  
>> 2658e50d Jaegeuk Kim 2015-06-19  848  	f2fs_leave_shrinker(sbi);
>> 2658e50d Jaegeuk Kim 2015-06-19  849  	mutex_unlock(&sbi->umount_mutex);
>> 2658e50d Jaegeuk Kim 2015-06-19  850  
>> 17c19120 Jaegeuk Kim 2016-01-29  851  	/* our cp_error case, we can wait for any writeback page */
>> b9109b0e Jaegeuk Kim 2017-05-10  852  	f2fs_flush_merged_writes(sbi);
>> 17c19120 Jaegeuk Kim 2016-01-29  853  
>> aff063e2 Jaegeuk Kim 2012-11-02  854  	iput(sbi->node_inode);
>> aff063e2 Jaegeuk Kim 2012-11-02  855  	iput(sbi->meta_inode);
>> aff063e2 Jaegeuk Kim 2012-11-02  856  
>> aff063e2 Jaegeuk Kim 2012-11-02  857  	/* destroy f2fs internal modules */
>> aff063e2 Jaegeuk Kim 2012-11-02  858  	destroy_node_manager(sbi);
>> aff063e2 Jaegeuk Kim 2012-11-02  859  	destroy_segment_manager(sbi);
>> aff063e2 Jaegeuk Kim 2012-11-02  860  
>> aff063e2 Jaegeuk Kim 2012-11-02  861  	kfree(sbi->ckpt);
>> a398101a Chao Yu     2017-06-14  862  
>> dc6b2055 Jaegeuk Kim 2017-07-26  863  	f2fs_unregister_sysfs(sbi);
>> aff063e2 Jaegeuk Kim 2012-11-02  864  
>> aff063e2 Jaegeuk Kim 2012-11-02  865  	sb->s_fs_info = NULL;
>> 43b6573b Keith Mok   2016-03-02  866  	if (sbi->s_chksum_driver)
>> 43b6573b Keith Mok   2016-03-02  867  		crypto_free_shash(sbi->s_chksum_driver);
>> b39f0de2 Yunlei He   2015-12-15  868  	kfree(sbi->raw_super);
>> 523be8a6 Jaegeuk Kim 2016-05-13  869  
>> 3c62be17 Jaegeuk Kim 2016-10-06  870  	destroy_device_list(sbi);
>> b6895e8f Chao Yu     2017-02-27  871  	mempool_destroy(sbi->write_io_dummy);
>> 4b2414d0 Chao Yu     2017-08-08  872  #ifdef CONFIG_QUOTA
>> 4b2414d0 Chao Yu     2017-08-08  873  	for (i = 0; i < MAXQUOTAS; i++)
>> 4b2414d0 Chao Yu     2017-08-08  874  		kfree(sbi->s_qf_names[i]);
>> 4b2414d0 Chao Yu     2017-08-08  875  #endif
>> 523be8a6 Jaegeuk Kim 2016-05-13  876  	destroy_percpu_info(sbi);
>> a912b54d Jaegeuk Kim 2017-05-10  877  	for (i = 0; i < NR_PAGE_TYPE; i++)
>> a912b54d Jaegeuk Kim 2017-05-10  878  		kfree(sbi->write_io[i]);
>> aff063e2 Jaegeuk Kim 2012-11-02  879  	kfree(sbi);
>> aff063e2 Jaegeuk Kim 2012-11-02  880  }
>> aff063e2 Jaegeuk Kim 2012-11-02  881  
>>
>> :::::: The code at line 830 was first introduced by commit
>> :::::: 638164a2718f337ea224b747cf5977ef143166a4 f2fs: fix potential panic during fstrim
>>
>> :::::: TO: Chao Yu <yuchao0@huawei.com>
>> :::::: CC: Jaegeuk Kim <jaegeuk@kernel.org>
>>
>> ---
>> 0-DAY kernel test infrastructure                Open Source Technology Center
>> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
> 
> 
> 
> .
> 


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
